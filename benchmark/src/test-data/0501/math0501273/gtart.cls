

%%%%%%%%%%%%%%%%%%          gtart.cls       %%%%%%%%%%%%%%%%%%
%
%  Format file for articles written in LaTeX for publication in 
%  Geometry & Topology and Algebraic & Geometric Topology.
%
%  For instructions see gtartins.tex and .ps and .pdf in gt/info/macros
%
%                            Version 1.3 
%
%%  Check for fairly recent version of latex2e :
%
\NeedsTeXFormat{LaTeX2e}[1994/12/01]
%
\LoadClass[11pt]{article}     % Basic style
\usepackage{amsthm}           % For GT theorem style (see below)
%
%  Basic layout :
%
\newskip\stdskip                      % standard vertical space
\stdskip=6.6pt plus3.3pt minus3.3pt    
%
\setlength{\textheight}{7.5in}          
\setlength{\textwidth}{5.2in}         
\flushbottom                           
\setlength{\parindent}{0pt}            
\setlength{\parskip}{\stdskip}
\setlength{\medskipamount}{\stdskip}
\setlength{\mathsurround}{0.8pt}     
\setlength{\labelsep}{0.75em} 
\newcommand{\stdspace}{\hskip 0.75em plus 0.15em \ignorespaces}
\let\qua\stdspace  %  useful abbreviation 
%
%  Some style commands (\ppar is for principal paragraph breaks, \sh is
%  for subheadings and \rk for remarks etc -- see also theorem style 
%  below ) :
%
\newcommand{\ppar}{\par\goodbreak\vskip 8pt plus 3pt minus 3pt} 
\newcommand{\sh}[1]{\penalty-800\ppar{\bf #1}\par\medskip\nobreak}
\newcommand{\rk}[1]{\ppar{\bf #1}\stdspace}    
%
%
%   Theorem style.  There are two recommended styles :
%
%   plain : for theorems, corollaries etc with heading bold
%   and left justified, optional note bracketed in roman type
%   and statement in slanted type.
%
%   definition : (alias remark)  for definitions, remarks etc with
%   heading bold and left justified, optional note unbracketed in 
%   slanted type and statement in roman type.
%   
%
%  Redefine the amsthm styles plain, definition and remark to GT style:
%
\newtheoremstyle{plain}{14pt plus6.3pt minus6.3pt}{7.4pt plus3pt minus3pt}%
{\sl}{}{\bf}{}{0.75em}{\thmname{#1}\thmnumber{ #2}\thmnote{\rm\stdspace(#3)}}
%
\newtheoremstyle{definition}{14pt plus6.3pt minus6.3pt}{7.4pt plus3pt minus3pt}%
{\rm}{}{\bf}{}{0.75em}{\thmname{#1}\thmnumber{ #2}\thmnote{\sl\stdspace#3}}
%
\newtheoremstyle{remark}{14pt plus6.3pt minus6.3pt}{7.4pt plus3pt minus3pt}%
{\rm}{}{\bf}{}{0.75em}{\thmname{#1}\thmnumber{ #2}\thmnote{\sl\stdspace#3}}
%
%  Default theorem style :
\theoremstyle{plain}               
%
% Adapt the amsthm proof environment to GT style :
%
\renewenvironment{proof}[1][\proofname]{\par
  \normalfont
  \topsep\stdskip \trivlist
  \item[\hskip\labelsep\bf
    #1]\ignorespaces
}{%
  \qed\endtrivlist\par
}
%                 Knuth's \square macro :
%
\def\sqr#1#2{{\vcenter{\vbox{\hrule  height.#2pt
	\hbox{\vrule width.#2pt height#1pt \kern#1pt \vrule width.#2pt}
	\hrule height.#2pt}}}}
%
\def\sq{\sqr55}           %    A small square for end-of-proofs. 
\def\qedsymbol{$\sqr55$}  %   (Define other size squares by varing the
%                         %   the two numbers.)
%
%  Some useful abbreviations :
%
\newcommand{\co}{\colon\thinspace}    %  Colon with correct spacing for maps.
\newcommand{\np}{\newpage}            %  Forced page break (new page).
\newcommand{\nl}{\hfil\break}         %  New line.
\newcommand{\cl}{\centerline}         %  Centerline
\def\gt{{\mathsurround=0pt\it $\cal G\mskip-2mu$eometry \&\ 
$\cal T\!\!$opology}}                %  The journal title in recommended style
\def\gtm{{\mathsurround=0pt\it $\cal G\mskip-2mu$eometry \&\ 
$\cal T\!\!$opology $\cal M\mskip-1mu$onographs}}  %  for monographs
\def\agt{{\mathsurround=0pt\it$\cal A\mskip-.7mu$lgebraic \&\ 
$\cal G\mskip-2mu$eometric $\cal T\!\!$opology}}  % AGT
%
%  Define the various ingredients of the title page and cope with
%  all reasonable alternative syntax including amsart and article
%  style :
%
\def\title{\let\\\par\@ifnextchar[\doubletitle\singletitle}
 \def\doubletitle[#1]#2{\def\thetitle{#2}\def\theshorttitle{#1}}
 \def\singletitle#1{\def\thetitle{#1}}
\def\shorttitle#1{\def\theshorttitle{#1}}
%
\def\author{\@ifnextchar[\doubleauthor\singleauthor}
\def\singleauthor#1{\edef\previousauthors{\theauthors}
 \ifx\theauthors\relax\def\theauthors{#1}\else
 \def\theauthors{\previousauthors\par#1}\fi}
\def\doubleauthor[#1]#2{\singleauthor{#2}}
\let\authors\author\let\secondauthor\author        % aliases
\def\shortauthors#1{\def\theshortauthors{#1}}
%
\def\address#1{{\let\newline\par\xdef\previousaddresses{\theaddress}}
 \ifx\theaddress\relax\def\theaddress{#1}\else
 \def\theaddress{\previousaddresses\par\vskip 2pt\par#1}\fi}
\let\addresses\address                             % alias
\def\secondaddress#1{{\let\newline\par\xdef\previousaddresses{\theaddress}}
 \ifx\theaddress\relax\def\theaddress{#1}\else
 \def\theaddress{\previousaddresses\par{\rm and}\par#1}\fi}   
%
\def\email#1{\edef\previousemails{\theemail}
 \ifx\theemail\relax\def\theemail{#1}\else
 \def\theemail{\previousemails\hskip 0.75em\relax#1}\fi}
\let\emails\email\let\emailaddress\email\let\emailaddr\email  % aliases
\def\secondemail#1{\edef\previousemails{\theemail}
 \ifx\theemail\relax\def\theemail{#1}\else
 \def\theemail{\previousemails\hskip 0.75em{\rm and}\hskip 0.75em
 \relax#1}\fi}
%
\def\url#1{\edef\previousurls{\theurl}
 \ifx\theurl\relax\def\theurl{#1}\else
 \def\theurl{\previousurls\hskip 0.75em\relax#1}\fi}
\let\urls\url\let\urladdress\url\let\urladdr\url      % aliases
\def\secondurl#1{\edef\previousurls{\theurl}
 \ifx\theurl\relax\def\theurl{#1}\else
 \def\theurl{\previousurls\hskip 0.75em{\rm and}\hskip 0.75em
 \relax#1}\fi}
%
\long\def\abstract#1\end#2#3\end#4%
{\expandafter\ifx\csname#2\endcsname\abstract
\long\gdef\theabstract{#1}\end{abstract}#3\end{#4}\else
\long\gdef\theabstract{#1\end{#2}#3}\end{abstract}\fi}
\def\endabstract{\relax}
%
\def\primaryclass#1{\def\theprimaryclass{#1}}
\let\subjclass\primaryclass                        % alias
\def\secondaryclass#1{\def\thesecondaryclass{#1}}
\def\keywords#1{\def\thekeywords{#1}}
%
%  Set \\ to \par and title page items to \relax to initialise macros :
%
\let\\\par\let\thetitle\relax\let\theauthors\relax
\let\theaddress\relax\let\theemail\relax\let\theurl\relax
\let\theabstract\relax\let\theprimaryclass\relax
\let\thesecondaryclass\relax\let\thekeywords\relax
\let\theshorttitle\relax\let\theshortauthors\relax
%
%%%% publication info and test defaults for authors:

\def\volumenumber#1{\def\thevolumenumber{#1}}
\def\volumename#1{\def\thevolumename{#1}}
\def\volumeyear#1{\def\thevolumeyear{#1}}
\def\pagenumbers#1#2{\def\startpage{#1}\def\finishpage{#2}}
\def\published#1{\def\publishdate{#1}}

\volumenumber{X}
\volumename{Volume name goes here}
\volumeyear{20XX}
\pagenumbers{1}{XXX}
\published{XX Xxxember 20XX}
%
%
%   Basic title page layout (edit this macro if you
%   wish to adjust the title page layout) :
%
\long\def\maketitlepage{    % start of definition of \maketitlepage
%
\vglue 0.2truein   % top margin
%
% title :
{\parskip=0pt\leftskip 0pt plus 1fil\def\\{\par\smallskip}{\Large
\bf\thetitle}\par\medskip}   
%
\vglue 0.15truein  % space below title
%
% authors :
{\parskip=0pt\leftskip 0pt plus 1fil\def\\{\par}{\sc\theauthors}
\par\medskip} 
%
\vglue 0.1truein   % space below author(s)
%
% address(es) email's and URL's (with switches to detect whether the
% optional items have been used) :
{\parskip=0pt\small\let\newline\\
{\leftskip 0pt plus 1fil\def\\{\par}{\sl\theaddress}\par}
\ifx\theemail\relax\else  % email address?
\vglue 5pt \def\\{\ \ {\rm and}\ \ } 
\cl{Email:\ \ \tt\theemail}\fi
\ifx\theurl\relax\else    % URL given?
\vglue 5pt \def\\{\ \ {\rm and}\ \ } 
\cl{URL:\ \ \tt\theurl}\fi\par}
%
\vglue 7pt         % space below addresses
%
%  Abstract:
{\bf Abstract}\vglue 5pt\theabstract
%
\vglue 9pt         % space below abstract
%
%  AMS numbers and keywords:
{\bf AMS Classification numbers}\quad Primary:\quad \theprimaryclass\par
Secondary:\quad \thesecondaryclass\vglue 5pt
{\bf Keywords:}\quad \thekeywords
%
\np  % page break at the end of the title page
}    % end of definition of \maketitlepage
%
%
%
\long\def\makeshorttitle{    % start of definition of \makeshorttitle
%
% title :
%
{\parskip=0pt\leftskip 0pt plus 1fil\def\\{\par\smallskip}{\Large
\bf\thetitle}\par\medskip}   

\vglue 0.05truein 

% authors :
%
{\parskip=0pt\leftskip 0pt plus 1fil\def\\{\par}{\sc\theauthors}
\par\medskip}%
 
\vglue 0.03truein 

% address(es) email's and URL's (with switches to detect whether the
% optional items have been used) :
%
{\small\parskip=0pt
{\leftskip 0pt plus 1fil\def\\{\par}{\sl\theaddress}\par}
\ifx\theemail\relax\else  % email address?
\vglue 5pt \def\\{\stdspace{\rm and}\stdspace} 
\cl{Email:\stdspace\tt\theemail}\fi
\ifx\theurl\relax\else    % URL given?
\vglue 5pt \def\\{\stdspace{\rm and}\stdspace} 
\cl{URL:\stdspace\tt\theurl}\fi\par}

\vglue 10pt 

{\small\leftskip 25pt\rightskip 25pt{\bf Abstract}\stdspace\theabstract

{\bf AMS Classification}\stdspace\theprimaryclass
\ifx\thesecondaryclass\relax\else; \thesecondaryclass\fi\par
{\bf Keywords}\stdspace \thekeywords\par}
\vglue 7pt
}    % end of definition of \makeshorttitle
%
\let\maketitle\makeshorttitle      %% alias
%
\long\def\makegtmontitle{   % start of definition of \makegtmontitle

\count0=\startpage

\gtm\nl        %   GT mongraphs (top left) 
{\small Volume \thevolumenumber: \thevolumename\nl 
Pages \startpage--\finishpage\nl}

\vglue 0.1truein   % top margin

% title
{\parskip=0pt\leftskip 0pt plus 1fil\def\\{\par\smallskip}{\Large
\bf\thetitle}\par\medskip}   
\vglue 0.05truein 

% authors :
%
{\parskip=0pt\leftskip 0pt plus 1fil\def\\{\par}{\sc\theauthors}
\par\medskip}%
 
\vglue 0.03truein 

%  abstract and classification numbers:

{\small\leftskip 25pt\rightskip 25pt{\bf Abstract}\stdspace\theabstract

{\bf AMS Classification}\stdspace\theprimaryclass
\ifx\thesecondaryclass\relax\else; \thesecondaryclass\fi\par
{\bf Keywords}\stdspace \thekeywords\par}\vglue 7pt

}   % end of definition of \makegtmontitle
%
\long\def\makeagttitle{   %%% start of definition of \makeagttitle
\agt\hfill      %   Journal title (top left) 
%   logo placeholder (top right)
\hbox to 60pt{\vbox to 0pt{\vglue -14pt{\normalsize \bf [Logo here]}\vss}\hss}
%
\break
{\small Volume \thevolumenumber\ (\thevolumeyear)
\startpage--\finishpage\nl
Published: \publishdate}

\vglue .25truein

% title
{\parskip=0pt\leftskip 0pt plus
1fil\def\\{\par\smallskip}{\Large\bf\thetitle}\par\medskip} \vglue
0.05truein

% authors :
%
{\parskip=0pt\leftskip 0pt plus 1fil\def\\{\par}{\sc\theauthors}
\par\medskip}%
 
\vglue 0.03truein 

%  abstract and classification numbers:

{\small\leftskip 25pt\rightskip 25pt{\bf Abstract}\stdspace\theabstract

{\bf AMS Classification}\stdspace\theprimaryclass
\ifx\thesecondaryclass\relax\else; \thesecondaryclass\fi\par
{\bf Keywords}\stdspace \thekeywords\par}\vglue 7pt

}   %%%% end of definition of \makeagttitle
%
%%%% for addresses at the end of the paper:
\def\Addresses{\bigskip
{\small \parskip 0pt \leftskip 0pt \rightskip 0pt plus 1fil \def\\{\par}
\sl\theaddress\par\medskip \rm Email:\stdspace\tt\theemail\par
\ifx\theurl\relax\else\smallskip \rm URL:\stdspace\tt\theurl\par\fi}}

\def\agtart{%   Full mock-up of AGT article style (for authors to test with)
%  get print centerpage:
\headsep 23pt
\footskip 35pt
\hoffset -4truemm
\voffset 12.5truemm
%  fonts for headline and footline
\font\lhead=cmsl9 scaled 1050
\font\lnum=cmbx10 
\font\lfoot=cmsl9 scaled 1050
%  headline and footline
\def\@oddhead{{\small\lhead\ifnum\count0=\startpage ISSN numbers
are printed here\hfill {\lnum\number\count0}\else\ifodd\count0
\def\\{ }\ifx\theshorttitle\relax \thetitle \else\theshorttitle\fi\hfill
{\lnum\number\count0}\else\def\\{ and }{\lnum\number\count0}
\hfill\ifx\theshortauthors\relax 
\theauthors\else\theshortauthors\fi\fi\fi}}\def\@evenhead{\@oddhead}
\def\@oddfoot{\small\lfoot\ifnum\count0=\startpage Copyright
declaration is printed here\hfill\else
\agt, Volume \thevolumenumber\ (\thevolumeyear)\hfill\fi}
\def\@evenfoot{\@oddfoot}
%  force \makeagttitle
\let\maketitlepage\makeagttitle\let\maketitle\makeagttitle
\let\makeshorttitle\makeagttitle}
%
\def\gtmonart{%   Full mock-up of GT monograph style (for authors to test with)
%  get print centerpage:
\headsep 23pt
\footskip 35pt
\hoffset -4truemm
\voffset 12.5truemm
%  fonts for headline and footline
\font\lhead=cmsl9 scaled 1050
\font\lnum=cmbx10 
\font\lfoot=cmsl9 scaled 1050
%  headline and footline
\def\@oddhead{{\small\lhead\ifnum\count0=\startpage ISSN numbers
are printed here\hfill {\lnum\number\count0}\else\ifodd\count0
\def\\{ }\ifx\theshorttitle\relax \thetitle \else\theshorttitle\fi\hfill
{\lnum\number\count0}\else\def\\{ and }{\lnum\number\count0}
\hfill\ifx\theshortauthors\relax 
\theauthors\else\theshortauthors\fi\fi\fi}}\def\@evenhead{\@oddhead}
\def\@oddfoot{\small\lfoot\ifnum\count0=\startpage Copyright
declaration is printed here\hfill\else
\gtm, Volume \thevolumenumber\ (\thevolumeyear)\hfill\fi}
\def\@evenfoot{\@oddfoot}
%  force \makegtmontitle
\let\maketitle\makegtmontitle\let\makeshorttitle\makegtmontitle
\let\maketitlepage\makegtmontitle}
%
\def\gtart{%   Full mock-up of GT article style (for authors to test with)
%  get print centerpage:
\headsep 23pt
\footskip 35pt
\hoffset -4truemm
\voffset 12.5truemm
%  fonts for headline and footline
\font\lhead=cmsl9 scaled 1050
\font\lnum=cmbx10 
\font\lfoot=cmsl9 scaled 1050
%  headline and footline
\def\@oddhead{{\small\lhead\ifnum\count0=\startpage ISSN numbers
are printed here\hfill {\lnum\number\count0}\else\ifodd\count0
\def\\{ }\ifx\theshorttitle\relax \thetitle \else\theshorttitle\fi\hfill
{\lnum\number\count0}\else\def\\{ and }{\lnum\number\count0}
\hfill\ifx\theshortauthors\relax 
\theauthors\else\theshortauthors\fi\fi\fi}}\def\@evenhead{\@oddhead}
\def\@oddfoot{\small\lfoot\ifnum\count0=\startpage Copyright
declaration is printed here\hfill\else
\gt, Volume \thevolumenumber\ (\thevolumeyear)\hfill\fi}
\def\@evenfoot{\@oddfoot}
%  force \maketitlepage
\let\maketitle\maketitlepage\let\makeshorttitle\maketitlepage}
%
%  A few definitions to adapt (or disable) various items from amsart 
%  style (not already covered above) :
%
\def\@message#1{\immediate\write16{#1}}
\def\thanks#1{\@message{ }
\@message{Thanks should not appear on the title page.}
\@message{Please give thanks as acknowledgements at the end of your 
introduction.}\@message{ }\relax}
\def\dedicatory#1{\@message{ }
\@message{Dedications should not appear on the title page.}
\@message{Please give these with your acknowledgements at the end of your 
introduction.}\@message{ }\relax}
\def\bysame{\leavevmode\hbox to3em{\hrulefill}\thinspace}
%
%   End of macros for basic title page layout
%
%
%   Some hacks to get various items of style correct :
%
%   Set footnotes in 10pt type:
%
\let\@footnote@\footnote
\def\footnote#1{\@footnote@{\small #1}}
\let\fnote\footnote    % useful abbreviation for \footnote
%
%  Set captions in 10pt type  (hack of excerpt from latex.ltx) :
%
\long\def\@caption#1[#2]#3{\par\addcontentsline{\csname
  ext@#1\endcsname}{#1}{\protect\numberline{\csname
  the#1\endcsname}{\ignorespaces #2}}\begingroup
    \@parboxrestore
    \small
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
  \endgroup}
%
%  Command to suppress the colon in captions (hack from article.cls) :
%
\def\nocolon{%
\long\def\@makecaption##1##2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{##1##2}%
  \ifdim \wd\@tempboxa >\hsize
    ##1##2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}}
%
%
%  Set displayskips to correct values :
%
\let\@document@\document
\def\document{\@document@%
\setlength{\abovedisplayskip}{\stdskip}
\setlength{\belowdisplayskip}{\stdskip}}  
%
%
%  Get the biblio style correct (10pt with small gaps):
%
\let\@thebibliography@\thebibliography
\def\thebibliography#1 {\@thebibliography@{999}\small\parskip0pt % 
plus2pt\relax}
%
%
%  Get item spacing reasonable :
%
\let\@itemize@\itemize
\def\itemize{\@itemize@\parskip 0pt\relax}
\def\@listi{\leftmargin28.5pt\parsep 0pt\topsep 0pt 
 \itemsep4pt plus3pt minus2pt}
\let\@listI\@listi
\@listi
%
\def\items{\bgroup\itemize}             % for comptibility 
\def\enditems{\enditemize\egroup}       % with gtmacros 
\let\itemb\item                         % (plain tex format)
%
%  Get enumeration labels like plain or amstex :
%
\renewcommand{\labelenumi}{{\rm (\theenumi)}}
%
%  and spacing to match \itemize: 
%
\let\@enumerate@\enumerate
\def\enumerate{\@enumerate@\parskip 0pt\relax}
%
\endinput
%
% History:
% Version 1.1:  14 December 97   
% Version 1.2:  (update for AGT) 18 October 00
% Version 1.3:  \gtart, \makegtmontitle and \gtmonart added 5.01.01
