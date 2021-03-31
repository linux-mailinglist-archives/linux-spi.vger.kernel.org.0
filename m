Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F94350787
	for <lists+linux-spi@lfdr.de>; Wed, 31 Mar 2021 21:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbhCaTkM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 31 Mar 2021 15:40:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35950 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbhCaTjl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 31 Mar 2021 15:39:41 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12VJdYhR009466;
        Wed, 31 Mar 2021 14:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617219574;
        bh=JMXn/JkBTuk+5TH5Q0BPZDISnz8/5kVGLPfZTOAxY3k=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=IXn2U2c8UwCGSDhUWbZ2zUPXXpkgVTIB3ddWx/RFxGQjNw1ZzQYBP9O/BMxsFBq9j
         yvajCrj8rG8hKbmMvyMFZ48aevdgm6OZE9BhMaT4kuyw9dhKI2pl3Z/DBExk8GoVUm
         qswl6FX+b+Trrqc5Zh2Sj+2Rr1RyabqP+DcN1GfE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12VJdYcN119377
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Mar 2021 14:39:34 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 31
 Mar 2021 14:39:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 31 Mar 2021 14:39:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12VJdXDL014920;
        Wed, 31 Mar 2021 14:39:33 -0500
Date:   Thu, 1 Apr 2021 01:09:32 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 4/4] dt-bindings: spi: Convert cadence-quadspi.txt to
 cadence-quadspi.yaml
Message-ID: <20210331193930.tzsvbjup3wpxmh26@ti.com>
References: <20210326130034.15231-1-p.yadav@ti.com>
 <20210326130034.15231-5-p.yadav@ti.com>
 <20210331191135.GF4758@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210331191135.GF4758@sirena.org.uk>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 31/03/21 08:11PM, Mark Brown wrote:
> On Fri, Mar 26, 2021 at 06:30:34PM +0530, Pratyush Yadav wrote:
> > From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> > 
> > There is no way as of now to have a parent or bus defining properties
> > for child nodes. For now, avoid it in the example to silence warnings on
> > dt_schema_check. We can figure out how to deal with actual dts files
> > later.
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

I did take a look by running git log on 
Documentation/devicetree/bindings/spi/ and there is no single style 
being used. Using "dt-bindings: spi:" is a popular choice. Some other 
commits just use "spi:". And then some use "spi: dt-bindings:". The last 
commit to touch cadence-quadspi.txt (fcebca39938f) used the prefix 
"dt-bindings: spi:".

So on the prefix front I think the subject is good enough. Of course, if 
you have any other preference then it can be re-worded but let's first 
be clear on what the expectation is. And then let's make sure to apply 
it to all future patches uniformly. This way future contributors won't 
have to take a guess on what the expected prefix is.

Apart from the prefix is there anything else to improve? IMHO the 
subject is good enough but I'm open to suggestions.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
