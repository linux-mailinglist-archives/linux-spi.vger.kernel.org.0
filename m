Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010E33C9D0B
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jul 2021 12:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbhGOKsW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Jul 2021 06:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhGOKsW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 15 Jul 2021 06:48:22 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C036EC06175F;
        Thu, 15 Jul 2021 03:45:29 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id n187-20020a4a40c40000b029025e72bdf5d6so1412290ooa.0;
        Thu, 15 Jul 2021 03:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=21z6x3uGaAS3cPhOSoiPCLeYV+Wo+jMvrMi4nUcNkSE=;
        b=t7zWNumyt4Xsr8ltBrUCip7SvNaVAH543/lxfqNZTLF6XiKaVFAWzFLFXzzEOj1Lf/
         bDowcMuYq2y57hvhLvpayH5CgvbrSWMLycOTXdFEcJoQ+eQYbd0m8e97vqB5/Un5tPte
         PifnfoUpYRFmuVaDDACaZ1g70wLfGfj6n3krhBPyE6f0n+EVNQzy7va7GtL5AqxGsG77
         hIut04ZzqzkupEvYUv5g+XE0d0ZUt7sB6hVmdmSDsKUXqJT9sSp2UBZ57ucKmGsbN2l3
         hXv3JXT9O8S2d+WYX2DLkzSv0jnI3m0tleltkyjm1ygMX3+EIhdYTxfoFIaNLb1JX+ch
         bw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=21z6x3uGaAS3cPhOSoiPCLeYV+Wo+jMvrMi4nUcNkSE=;
        b=HgHwGXDK/RdIHEz8POCwTs6bUvb2MXYgdL/erM/KVceQPj6NVqo4c+L+0wysnoxWCz
         Bt2BVEhZD4jxHVSxM55CyaDJSM91re4joluhkJeCPiMk3p12dixPYUeWuFuhjn9SHRpl
         SZIfqR/1z6kRv2oFUhW0hUfOSULLcvDhMn8DXctV8wwP79JHdatSah/QUhZeTVDlamoq
         jpbij6dNrhz+tOXRndsoMlAfSvDw2ve+yeqmo55PzFfQ8rEYknjjdhEAjrw0rQEF2rjK
         VmR/iB0RTsDzkqpLMsugrLZsOnJhs3Xj0shrBlGl8ETUvSVcUoDViiKE56koKBdyACdV
         aezg==
X-Gm-Message-State: AOAM533xxcfozmW8CWUhccdOolvvGi6g7+/Qt0NptCTa03EHfGlnM2ri
        6dHl8Gb9+x3dWOCKoygQ8mSlZUsbd1uD6zafg7A=
X-Google-Smtp-Source: ABdhPJxQK6XEi3wJ76O+KuFTIP+hqZ5rdw5aLn6QPZfkKiGJgWB/yFSfTiWUIjgTWcGO03fNiWxkP2FtIXA/FQ2yDaQ=
X-Received: by 2002:a4a:5e81:: with SMTP id h123mr2876520oob.11.1626345929056;
 Thu, 15 Jul 2021 03:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210715082536.1882077-1-aisheng.dong@nxp.com>
 <20210715082536.1882077-3-aisheng.dong@nxp.com> <AS8PR04MB8466DF30C1AE4F9CEA8574B8E0129@AS8PR04MB8466.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8466DF30C1AE4F9CEA8574B8E0129@AS8PR04MB8466.eurprd04.prod.outlook.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Thu, 15 Jul 2021 18:43:28 +0800
Message-ID: <CAA+hA=QVQchihR1ZDcbJGeidKjuEX0awHAHDBveOk4fzwsUjDw@mail.gmail.com>
Subject: Re: [EXT] [PATCH 2/7] dt-bindings: spi: flexspi: convert to json schema
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jul 15, 2021 at 5:25 PM Kuldeep Singh <kuldeep.singh@nxp.com> wrote:
>
> Hi Aisheng,
>
> > -----Original Message-----
> > From: Dong Aisheng <aisheng.dong@nxp.com>
> > Sent: Thursday, July 15, 2021 1:56 PM
> > To: devicetree@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>;
> > kernel@pengutronix.de; Aisheng Dong <aisheng.dong@nxp.com>;
> > dongas86@gmail.com; robh+dt@kernel.org; shawnguo@kernel.org; Ashish
> > Kumar <ashish.kumar@nxp.com>; Yogesh Gaur <yogeshgaur.83@gmail.com>;
> > Mark Brown <broonie@kernel.org>; linux-spi@vger.kernel.org
> > Subject: [EXT] [PATCH 2/7] dt-bindings: spi: flexspi: convert to json schema
> >
> > Caution: EXT Email
> >
> > Besides the conversion work, also added the missing clock property in the
> > original binding doc according to the current dts and driver implementation.
> > Otherwise, make dtbs_check will fail.
> > Also fixed example according to new jason schema.
> >
> > Cc: Ashish Kumar <ashish.kumar@nxp.com>
> > Cc: Yogesh Gaur <yogeshgaur.83@gmail.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: linux-spi@vger.kernel.org
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>
> There's already a similar patch sent upstream for conversion to yaml format. Please see[1].
>

Thanks for letting me know.
Then this one can be dropped. :-)

Regards
Aisheng

> Regards
> Kuldeep
> [1] https://patchwork.kernel.org/project/spi-devel-general/patch/20210428102417.1936520-1-kuldeep.singh@nxp.com/
