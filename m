Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C80E44F7B1
	for <lists+linux-spi@lfdr.de>; Sun, 14 Nov 2021 12:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhKNL4j (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 14 Nov 2021 06:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhKNL4j (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 14 Nov 2021 06:56:39 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A53EC061746
        for <linux-spi@vger.kernel.org>; Sun, 14 Nov 2021 03:53:44 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id g17so37649120ybe.13
        for <linux-spi@vger.kernel.org>; Sun, 14 Nov 2021 03:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=l2AjIcA200luhAvIV6Y4Gf8Evv6mr+gMr0zSOMeBGF0=;
        b=NIccaHcX3tvhp2OaMXWmcLKTG/ymsADT6mkP7BUHnzI+/PrEz/Gxb5JXa5KZfTFWsX
         Zi79ZBs7j8ByA/qG3q3Xx3xrtNwIIXmaBp63K/zFuUbYPy2K7ByPT3kSf7uHc54LmCqw
         7G45N8UwhuafOuwgfn0oBfflJdxEUhG8t+KGhqvzNHrQm24Qn5u+knjOhasV5NqEnoHr
         Ct2ZfSU9NTqZ0GuXrnYFVpJ041T7rNfytha9VAdHAw5VbgNpquKzChRWYMijSFou/3wc
         63KtkjsGu/Reu+gY6qsXeieM++jE7uNmefB189pE/5+99hEUNw0UXlXMdym0XzQWN1kn
         A91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=l2AjIcA200luhAvIV6Y4Gf8Evv6mr+gMr0zSOMeBGF0=;
        b=zzARcTTD1tfHnSL4ptrqfTYyr7sOiT+BT0zBFLPgDzwdmNCnI9JhLhU+LckRHRpOmP
         Zz6UlYopqUAuCQO74F1XwWymJo3cCP/sbXRdCM0H2EDXlPA9OnYA9s/wzGvvqM87sVfo
         cLS6n/jW/llV9JxkEfTU1G/HpK5YdglIb0aJ7JBZwCrCjl0BJLcNxqELB6HABWfwNviT
         mkLyjJXesyd7LT3F+aaGVN3TjGgLlrOBJzTl/ulSXW6zP4A+WNYi/KukQs5nZSIQM+By
         Lt7sehVtkMdzAxh5EUYHYAYyuUkqqgOriZbZ4FhMcs56HuqZgtXiytn3ov6F2C3K1m0p
         gbyw==
X-Gm-Message-State: AOAM533xD0WHY8pS11a1jDD7CJaV/SOGlVYrrwK1ReqmcExfGfxzFaF0
        VhUMWnYZIXodmYHcbvj55k4Hh/QwQuDFExlnTMSXk+x2e+8=
X-Google-Smtp-Source: ABdhPJzfJy86v1LT9T9PbceGaJSdGiJzJxjTp4ZpZ3xskUoALrFNydaLEg1SS75REKrgTUuFEzaZClYi47zRER8lv+c=
X-Received: by 2002:a25:69c3:: with SMTP id e186mr725094ybc.249.1636890823604;
 Sun, 14 Nov 2021 03:53:43 -0800 (PST)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <ceo.teo.en.ming@gmail.com>
Date:   Sun, 14 Nov 2021 19:53:40 +0800
Message-ID: <CAMEJMGHcCL=pCw43GBkqzp-DGxe2B0JW8cog-daUyOHes+U8uA@mail.gmail.com>
Subject: I discovered that Aruba Instant On 1930 24G 4SFP/SFP+ JL682A Switch
 is Running an Operating System with Linux Kernel 4.4.120!
To:     linux-spi@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Subject: I discovered that Aruba Instant On 1930 24G 4SFP/SFP+ JL682A
Switch is Running an Operating System with Linux Kernel 4.4.120!

Good day from Singapore,

I discovered that Aruba Instant On 1930 24G 4SFP/SFP+ JL682A Switch is
Running an Operating System with Linux Kernel 4.4.120!

INTRODUCTION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

My name is Mr. Turritopsis Dohrnii Teo En Ming, 43 years old as of 14
Nov 2021. I live in Singapore. Presently I am an IT Consultant with a
Systems Integrator (SI)/computer firm in Singapore. I am also a Linux
and open source software and information technology enthusiast.

You can read my autobiography on my redundant blogs. The title of my
autobiography is:

=E2=80=9CAutobiography of Singaporean Targeted Individual Mr. Turritopsis
Dohrnii Teo En Ming (Very First Draft, Lots More to Add in Future)=E2=80=9D

Links to my redundant blogs (Blogger and WordPress) can be found in my
email signature below. These are my main blogs.

I have three other redundant blogs, namely:

https://teo-en-ming.tumblr.com/

https://teo-en-ming.medium.com/

https://teo-en-ming.livejournal.com/

Future/subsequent versions of my autobiography will be published on my
redundant blogs.

My Blog Books (in PDF format) are also available for download on my
redundant blogs.

Over the years, I have published many guides, howtos, tutorials, and
information technology articles on my redundant blogs. I hope that
they are of use to information technology professionals.

Thank you very much.




-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link:
https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

***************************************************************************=
*****************

Singaporean Targeted Individual Mr. Turritopsis Dohrnii Teo En Ming's
Academic Qualifications as at 14 Feb 2019 and refugee seeking attempts
at the United Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan
(5 Aug 2019) and Australia (25 Dec 2019 to 9 Jan 2020):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
