Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA980348635
	for <lists+linux-spi@lfdr.de>; Thu, 25 Mar 2021 02:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhCYBGv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 21:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhCYBGp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 21:06:45 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A24C06174A;
        Wed, 24 Mar 2021 18:06:44 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ce10so212690ejb.6;
        Wed, 24 Mar 2021 18:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QyuEbp79sFDYbVUwlKgrT3LfkDPXhFyHRIfRwWBNnR0=;
        b=dvATg1dMAPoLoOLjHBOVCfDoI3j9n5CnLc2/CgV5oLkTw+2nL7cIeeRWMapD9xCZAS
         YcG8ksUQQuumx1IAYgRBPha9JrspUyivUC0jLMfMiDngQVmhzIQynadL4Yz3OXauECRj
         +KjcoFSu2YHhASm29JwRy1Duc1c8JNsRPRYHIWDGn56i7nZ91tifgaIYwpwLy8/woYif
         w3aZmBKE2aZOWuC5nVFVYBFqgDfe1MjlIINCe9Ipi2a9QjNWuOF3jlHx7Mnj/9OTDhlp
         qd/qe00hrPiohh8AqKe9cSMZhWwYdkE44zqaYiOuweHAvtU7X+G+mkinWyfXFatnTy2X
         Ibdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QyuEbp79sFDYbVUwlKgrT3LfkDPXhFyHRIfRwWBNnR0=;
        b=BgB6hi7ekFGR6joEyZVq+U06I3YwJ5c7Qy8HilxBK45VQ5P4cPo587RCQ1Lls8e1VX
         n0I4GLsbSCDjpImzU/olfqJaoCq3Bi0IrPjQ4gJci7kb0Wr99nk6zwx0azoBZDqwTtg0
         /cD4TWGjGYSXIT/G3a7h4dGdoVARjA/THE+ye9LceoPjZiolUG6Dy9/otRXsl/n/Zd37
         7pl5byiluU+SAnrcBES6eyLLzNnmy0PmkGZq4bRf92tE0jH0xYCKlP0aQ9YS1X8Dr4hT
         QcpciQXThTMXzaN3NaR4LW57JugujwlC1+9mRXjP9w5ySnO1nesEIBG4l2D4Kba1nNzB
         a+wQ==
X-Gm-Message-State: AOAM532H+j9nGFQ8A/QeBORPZCQLN6AD0kDebgMRJc9cHeXSQjelGsCh
        OrTaUBzMmzdiPJ7dNPuro+Y=
X-Google-Smtp-Source: ABdhPJxh7dE1K0DHwlsfznIPjQhExr4agS0ZTI2cZ0n0KlgDTuInl/2y+pu4Uc/IgZ5fw8RQXJ+lQg==
X-Received: by 2002:a17:906:51c3:: with SMTP id v3mr6667120ejk.497.1616634403336;
        Wed, 24 Mar 2021 18:06:43 -0700 (PDT)
Received: from skbuf (5-12-16-165.residential.rdsnet.ro. [5.12.16.165])
        by smtp.gmail.com with ESMTPSA id w6sm1672755eje.107.2021.03.24.18.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 18:06:42 -0700 (PDT)
Date:   Thu, 25 Mar 2021 03:06:41 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Kuldeep Singh <kuldeep.singh@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [EXT] Re: [PATCH] dt-bindings: spi: Convert Freescale DSPI to
 json schema
Message-ID: <20210325010641.4uaiw54xhqfyauqz@skbuf>
References: <20210315121518.3710171-1-kuldeep.singh@nxp.com>
 <20210315205440.lb6hcrvzxtqxdb5x@skbuf>
 <DB6PR0402MB27580AF77ED738B995616EB5E06B9@DB6PR0402MB2758.eurprd04.prod.outlook.com>
 <20210316101506.rkqcxkw6slv4vuhr@skbuf>
 <20210324181403.GC3320002@robh.at.kernel.org>
 <20210324185302.dxi2wurf7lgr5yxi@skbuf>
 <CAL_Jsq+8xXcLr8sLk+gj9y+FOi9kiEtRHTxDUV+yxm9CXS+jbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+8xXcLr8sLk+gj9y+FOi9kiEtRHTxDUV+yxm9CXS+jbQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Mar 24, 2021 at 01:20:33PM -0600, Rob Herring wrote:
> In addition, "fsl,ls1088a-dspi" is not known by the Linux driver, so a
> fallback is needed.

This is a good point, the LS1088A went completely off of my radar,
thanks for pointing it out.
