Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC8033D19D
	for <lists+linux-spi@lfdr.de>; Tue, 16 Mar 2021 11:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbhCPKPX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Mar 2021 06:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbhCPKPJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Mar 2021 06:15:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FACC06174A;
        Tue, 16 Mar 2021 03:15:09 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ci14so70999817ejc.7;
        Tue, 16 Mar 2021 03:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=77E0sK5htid3cTi1HbVWtxEXQROVn0j5JhaPDUXKt4Y=;
        b=VTtyWZplkzBRJ3ClYoxTYqpLZXCnWRX+/+7p11pv3yLSAiR0npxgXNCgxqPieONGJI
         vY08B50lWfSUoJS4LW+WQOerUxCy1i09MV9FzMtIDp0MQ0hn9QbRurCJwxgV/fX2mEqT
         p3e/R8sjYwBfjRWubRlEyXSQm7/6tgz0G5V4MCj4nyyVwReOJTWHGbncB9KitcwdnaoU
         Zl5SXby8TNugQtQo2VI6707dEu7uPW+y8rFo07PBro5k4u5OT3X81uaPFfptTNkfVu+V
         2S2zPJhiJq80MOtUDCM2RvlkexV3hEfW+cdIiIgJzyHb3jfcR9FLeTuyMClDwzdqEUUI
         /wHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=77E0sK5htid3cTi1HbVWtxEXQROVn0j5JhaPDUXKt4Y=;
        b=euqTycbCJW56K/u71+SwYm5IDrMu3A+INA609XCQMP42DsD02wXqZH8ZlVSHt18MHY
         TMwNYJvL8jo+IWh4SS9o8rRyUstttwUAQUe48P2n1x7b56EG/hiO/1p599sTDiZeX6Xt
         Mq7Sp8BRhYC8m9Zw3S7EaC+Qs18Q9QAVUrULKzedcYYnsMBEKAhqFo5hhiC9RCF2WwSt
         ICP2nAtVTyKC76UCarUI6OrJEVxp2aynUEa8rP/kQuxcTW2bx7L4OpzV67Fc9kTklPNK
         JU1Cm3BK3w96SZTfpbPSJ0TsDqc9sziuKE3MU4q7I/DdEQyFXASvOGqbyVZUBoLrW40+
         VLfg==
X-Gm-Message-State: AOAM530+VHCfFek9Z5aj3uIGokrmu4zFZjE6A0OcAyTqmNx40K4ciBwO
        QJbHn8eLMyvoGewuDM6IGVI=
X-Google-Smtp-Source: ABdhPJz/KkLwMnv8WASA17OH2zZ16aCXuzYPqwr76GspbnLGslXWyKqWM/X6PLSzNEIXUls6CebgMA==
X-Received: by 2002:a17:907:2716:: with SMTP id w22mr28748171ejk.328.1615889707842;
        Tue, 16 Mar 2021 03:15:07 -0700 (PDT)
Received: from skbuf (5-12-16-165.residential.rdsnet.ro. [5.12.16.165])
        by smtp.gmail.com with ESMTPSA id y17sm9085001ejf.116.2021.03.16.03.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 03:15:07 -0700 (PDT)
Date:   Tue, 16 Mar 2021 12:15:06 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [EXT] Re: [PATCH] dt-bindings: spi: Convert Freescale DSPI to
 json schema
Message-ID: <20210316101506.rkqcxkw6slv4vuhr@skbuf>
References: <20210315121518.3710171-1-kuldeep.singh@nxp.com>
 <20210315205440.lb6hcrvzxtqxdb5x@skbuf>
 <DB6PR0402MB27580AF77ED738B995616EB5E06B9@DB6PR0402MB2758.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB27580AF77ED738B995616EB5E06B9@DB6PR0402MB2758.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Mar 16, 2021 at 06:08:17AM +0000, Kuldeep Singh wrote:
> Compatible entries in conjugation require enum and const pair.
> For example, ls1012a.dtsi uses compatible = "fsl,ls1012a-dspi","fsl,ls1021a-v1.0-dspi";
> Same goes for LS1028 as well.
> 
> Therefore, can't mention the compatible entry as single entity otherwise
> it may fail "make dt_binding_check" and "make dtbs_check".
> 
> > 
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/fsl,qoriq-clockgen.h>
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +
> > > +    soc {
> > > +        #address-cells = <2>;
> > > +        #size-cells = <2>;
> > > +
> > > +        spi@2100000 {
> > > +            compatible = "fsl,ls1028a-dspi", "fsl,ls1021a-v1.0-dspi";
> > 
> > This doesn't need the "fsl,ls1021a-v1.0-dspi" compatible, can you please remove
> > it?
> 
> I have taken this example from LS1028a.dtsi and it uses these compatibles in conjugation.
> If "fsl,ls1021a-v1.0-dspi" is not required, then it should also be removed from device-tree
> As well as from bindings both.

Yes, the second compatible is never required by the driver and should be
removed from existing device trees if that makes "make dtbs_check" fail.
