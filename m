Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44A625C432
	for <lists+linux-spi@lfdr.de>; Thu,  3 Sep 2020 17:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgICPFo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 3 Sep 2020 11:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbgICN6P (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 3 Sep 2020 09:58:15 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6D6C061A1E;
        Thu,  3 Sep 2020 06:47:49 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id t7so3072274ljo.13;
        Thu, 03 Sep 2020 06:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5IkJp9DRjjctTj4yQaRDfSKfYFKp/SZ4X/D7aiQqs+Q=;
        b=OnTWGDupQD64VHCo/u9bL3+tiNJ2NIkF8cEeaaUnpJtO+P5kIqiefJgSrYjSAQ5HNz
         zeZtIlycu0wL7LRVTip4mNsbSL1hjnsVQEy3zWE+B9sY0LapBpVzZ/+6gq0+JI2rTzur
         SBDI4jkqc1RDp0gU221csn3ICYPAs7/r3jbJJ2jCXgnk31nJa6gCUjusVXjew91854Cx
         UC7hqH6NpMzOZjQxrwc4mz8GE38Uq+Ok+vzFLgGL+us/CIBLsKjg2VKtv61aFhhZyBso
         EXC2FT9JfKzqZznmrEBwWWyWJzHOUy/eo74s4PB33Ikc0gU12EboYZ8LlFOb8rQad+Jn
         bfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5IkJp9DRjjctTj4yQaRDfSKfYFKp/SZ4X/D7aiQqs+Q=;
        b=Z0ZUtXrV2MDsVBZAOhNc2YdJaVKC53nepDeDd/DF1Er8EspOsXMwGge8Rii7ocx8Mc
         16IcBJF5L2Dg2tiuffMdNxKzoLQ+5BiRULeHFbzlskF9TkJVMeHXtvsnY3HcWYj1D6Iq
         RrFqnLr4Jf2xsesQ2tGiwjhLZh5XO7Mqz+PyWtbZnpZ3KpaR8YDywUyriGA6MOcSCGqm
         YpzRA3Cr/dY3iQ0oiH54i7I/IprQe3e42YbFr7hN1b8vUUwdrx0wZD1zwEdo2etFiNe3
         wU+3/xI4gv5r+Jj8lCQ8h7X2O0UDxYBrhIqktFBj8lqhej2tux10a79eR0Gc3myc/wDL
         t48w==
X-Gm-Message-State: AOAM530Zz3mttMqOkfhK/C5UagCs5hF0Uiv9WibnSgaGsCpYbc5YU/mR
        j5M+7/1mHroUXUblfNsypD29f7imqqo3RnXBtc8=
X-Google-Smtp-Source: ABdhPJwDdx3G0+9vSDmc/QFH9b0DWyx8r/HgJprZSkOT+jjXTTPq0AkqkkBKi/OhQnVgbF2lp97G9/OB66Ez2GN9K3o=
X-Received: by 2002:a2e:1417:: with SMTP id u23mr1438912ljd.44.1599140866369;
 Thu, 03 Sep 2020 06:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <ecfa135b7b83a31bed821ec0740ab3cf1d39da15.camel@ew.tq-group.com>
 <20200903132241.GB4771@sirena.org.uk> <ce08696b6bf2b3eaa84d6f056f47a8240c7479f4.camel@ew.tq-group.com>
In-Reply-To: <ce08696b6bf2b3eaa84d6f056f47a8240c7479f4.camel@ew.tq-group.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 3 Sep 2020 10:47:34 -0300
Message-ID: <CAOMZO5DDhSJHj_PN4ckzYedV3mvNC1=+RvNT6TM2s-rE5iHxcQ@mail.gmail.com>
Subject: Re: spi-imx: correct interpretation of num-cs DT property?
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Matthias,

On Thu, Sep 3, 2020 at 10:40 AM Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:

> As currently no in-tree DTs use the num-cs property for spi-imx and
> it's not documented, should support for it be dropped from the driver
> altogether?

Yes, it makes sense to drop num-cs support from the spi-imx driver.

Care to send a patch?

Thanks
