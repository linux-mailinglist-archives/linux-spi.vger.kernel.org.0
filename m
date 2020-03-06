Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87EBE17B867
	for <lists+linux-spi@lfdr.de>; Fri,  6 Mar 2020 09:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgCFIjJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Mar 2020 03:39:09 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41226 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCFIjI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Mar 2020 03:39:08 -0500
Received: by mail-oi1-f196.google.com with SMTP id i1so1776439oie.8;
        Fri, 06 Mar 2020 00:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T0YCzrMdqSOCLtIegMTpdezODLLacO22ik9gMI/OohA=;
        b=TTLiPTzKpN1qWN3EEFTC/u8fB+61JOECJD8HcEHhufaX9NawgXNP+CtoO70w1n7/rT
         gbuiAvBLa7ov+c7HyMDa/2ttOgLylNuZpso5Nq1Evc3IB3CEveDPOKMmpnLMpLzUg/Tz
         F0hvdMD5bfrhjOSGDqDyYvtD06RWhIju2DEzsCbkC/SbhJf6bYn2HY369DIzAVC7TSyA
         FBWXloXfGAfNCdgRp8h805Ik77umoY8tRXYzNbl5RMyAywhRL7u2JUs6i0FKOfttOWKp
         RQMR/yFbrg2cxmXtRtipBXAR8HWBO7yaIqDiYg8MD7UTpGWv72Mixj81Ymqt6+uHkfqu
         HO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T0YCzrMdqSOCLtIegMTpdezODLLacO22ik9gMI/OohA=;
        b=FMadoadKMcIzR2hbwUMCXP47urT1J2cSBYOI/B26dmHBB7B63mG6hBydC6BB9Qhr8I
         n/2ig8MNpMJr3kGdFLt7cekshHMOA0ArKMqqEkhK84OdzZ2n2Hn/7t7w2BSQmj0QNd9x
         Y13/OpEKylC53iX4PLUH2+6EdNFYdkMe6Z8YCE+wiL7RHiVsxqaoqBFP9+W8XeH0OJ48
         T933XL1tPMxEifk4b6Z5xiZrxvsOrluYcY1ec4NLt3RJYeTeTFIuD/sHhSV/9Y8Bdyce
         9S799i2Vk7u5Uj8Aw0xYopHrNRjhGwQ+hCqz6dCNrX09VOgUcEoEdGWRilAYHq5sUj3Z
         apXw==
X-Gm-Message-State: ANhLgQ3eWehONtv85f6qNFVxv7NEFTMi97EjPLwxDjrzZhirZIjkgHIq
        gH/u827M6eL8YcmeD7EvWO3I96CgEQLobHsuzhkXxlkR
X-Google-Smtp-Source: ADFU+vuScZHY2OPIYB1fCsKFbxTT74N+YFxRuCirOj8v8ukqPreNKXLIN5Ul0y9nHN0b8tlqiERNHVdq1j4ynySyfE0=
X-Received: by 2002:aca:1101:: with SMTP id 1mr1851279oir.30.1583483948255;
 Fri, 06 Mar 2020 00:39:08 -0800 (PST)
MIME-Version: 1.0
References: <20200228043636.559915-1-gch981213@gmail.com> <20200228043636.559915-4-gch981213@gmail.com>
 <20200303224706.GA22867@bogus>
In-Reply-To: <20200303224706.GA22867@bogus>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Fri, 6 Mar 2020 16:38:57 +0800
Message-ID: <CAJsYDVK62jqkLimdZWbLE2wgEAuVi5HdY231nR_wPj4TiMtX9w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: convert mtk-quadspi binding doc for spi-mtk-nor
To:     Rob Herring <robh@kernel.org>
Cc:     linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Mar 4, 2020 at 6:47 AM Rob Herring <robh@kernel.org> wrote:
> > 3. replace binding example with a mt7629 one because this is the
> >    only one I know the interrupt assignment.
>
> That doesn't really matter. It would be less churn without that change
> and examples are just examples.
> [...]
> > -
> > -     flash@0 {
> > -             compatible = "jedec,spi-nor";
> > -             reg = <0>;
> > -     };
>
> Better to leave this in the example IMO.
>
> Rob

I'll revert example changes and add a dummy interrupt binding instead in v3.

-- 
Regards,
Chuanhong Guo
