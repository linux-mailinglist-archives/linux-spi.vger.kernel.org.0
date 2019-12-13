Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDEB111E164
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2019 11:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfLMKBk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Dec 2019 05:01:40 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46402 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfLMKBk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Dec 2019 05:01:40 -0500
Received: by mail-ot1-f68.google.com with SMTP id g18so5755151otj.13;
        Fri, 13 Dec 2019 02:01:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tF95qMF9ERW6gHpXhamcEeeL/6m7C6A3FVygCN+4SDI=;
        b=CTaa/J9J4x/WE2Or90F5I1neXdqU8u0YTnLvCO4zqWjWQI9EGCSh28uo9SN5g4Ra0i
         Lf9mca0bMFXJdk0KW2MpegbD6T/y2d/NF17TLS2mdadP1Juv+Dm0jrgLTe+ZljeJhv45
         ORcjGVjs9FSv60wbWu94GgxvHyJpJMP6IBjr3jhSs+MW4+Bi2BGs830COJh5ncpbp8IS
         C19G+QAb4z/zvuWhYvAVjNz2InmxlJxiQPvSu5WUHkbNSXOBVbx+SGMfg8G8R/PQOMPs
         RAeWcbtGz9CK9OTRciA3gf3SNfmLShXDw8eZ/lRmO+WKtTiH36rc0YZ7ouPR9jE69GNZ
         qtDA==
X-Gm-Message-State: APjAAAVoxBhz3KZRFYUT01czlQtbPhtEGJouHyyCG3UoIWCSr2M6JTW0
        Qc/sn+Qn9ryYUGoyh75n/lPWdLIoxrtM/84AKa8=
X-Google-Smtp-Source: APXvYqzvSmx2I4nRiVrv54hjftKpN1VACtQuojp4ST7ypJsb2lH/wSFc8YGIvXq0c6SbfHWhtr62WCABJHgLouaYaEI=
X-Received: by 2002:a9d:6c81:: with SMTP id c1mr13985832otr.39.1576231298989;
 Fri, 13 Dec 2019 02:01:38 -0800 (PST)
MIME-Version: 1.0
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <20191206134202.18784-2-chris.brandt@renesas.com> <37c13497-d20f-583f-72d7-1e3c8a241990@cogentembedded.com>
 <TYXPR01MB1568ED4D40CEC399E64F6A2B8A550@TYXPR01MB1568.jpnprd01.prod.outlook.com>
In-Reply-To: <TYXPR01MB1568ED4D40CEC399E64F6A2B8A550@TYXPR01MB1568.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 Dec 2019 11:01:27 +0100
Message-ID: <CAMuHMdWCgOsj_ZWF-+f-5XjZU9RSCm6Ww3gBmYQeSGz0B77_ig@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] spi: Add SPIBSC driver
To:     Chris Brandt <Chris.Brandt@renesas.com>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Chris,

On Thu, Dec 12, 2019 at 9:19 PM Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Thu, Dec 12, 2019, Sergei Shtylyov wrote:
> >    As you can see, the deleted file is back after unmount/re-mount...
>
> Did you do a 'sync' before you unmounted?

Does it fail without? If yes, that must be a jffs2 bug.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
