Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71B5F10AF0E
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 12:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfK0Ly3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 06:54:29 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:55788 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726496AbfK0Ly3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Nov 2019 06:54:29 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARBpfxB003370;
        Wed, 27 Nov 2019 05:54:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=dhIaUkoS+DrpcsuYOVcEaDmzt68tdOk/Gzkri67wU0c=;
 b=Iaujsh5WQ5JVpEqCkMByHIkWEKZGQgAC1aqF2s9bGiN+g7erZPIRNT6sg2dl6EXpM8co
 a/Bh9c4YCBHiTYvfVkekAfKE7N2uRMS0jO9tLJGKb3ag7I6I7tbfR49+TgxNQEw+WqAq
 cbulQxOPSWnjPyiWOf+tuyRgDlCLbwMmGbr7AH+DoD0Iy7W0+UZM+i+k5ls0WRHYoNYm
 Tf+kWrsYazc+OTLv0ZYWCT3pt5ROw+DMsj52TPqJqKnyx514uqB6JYzxwXbHc24sT+Nc
 ExHk7K6YnfB1dD+QWtOKqK7bvCTub5ormETI7yOe67OgKT1XwCoizKAesD/6LJuKq+bY Zg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([5.172.152.52])
        by mx0b-001ae601.pphosted.com with ESMTP id 2whda3rw5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Nov 2019 05:54:24 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 27 Nov
 2019 11:55:13 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Wed, 27 Nov 2019 11:55:13 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D14612C8;
        Wed, 27 Nov 2019 11:54:19 +0000 (UTC)
Date:   Wed, 27 Nov 2019 11:54:19 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Gregory Clement <gregory.clement@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: cadence: Correct handling of native chipselect
Message-ID: <20191127115419.GA10451@ediswmail.ad.cirrus.com>
References: <20191126164140.6240-1-ckeepax@opensource.cirrus.com>
 <CACRpkdYc=2vWte+gFp0m6RvWSu=+qT=WWUzag0N1FUBmbSCOOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACRpkdYc=2vWte+gFp0m6RvWSu=+qT=WWUzag0N1FUBmbSCOOw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911270103
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Nov 27, 2019 at 11:42:47AM +0100, Linus Walleij wrote:
> On Tue, Nov 26, 2019 at 5:41 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> The original patch
> f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
> came with the assumption that native chip select handler needed
> was to be converted to always expect a true (1) value to their
> ->set_cs() callbacks for asserting chip select, and this was one of
> the drivers augmented to expect that.
> 

Which is fine, I am not greatly invested in either symantics
of the set_cs callback although if we were changing that we
should have probably updated the kerneldoc comments for it.

Although I do have a question if that is that case what is the
expected way to handle the polarity of the chip select? Because
it seems to me you would end up with each driver checking the
SPI_CS_HIGH flag in set_cs and doing the invert locally, whereas
with the pass the logic level system the core can centralise that
inversion.

> As
> 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH setting when using native and GPIO CS")
> essentially undo that semantic change and switches back to
> the old semantic, all the drivers that were converted to expect
> a high input to their ->set_cs() callbacks for asserting CS need
> to be reverted back as well, but that didn't happen.
> 
> So we need to fix not just cadence but also any other driver setting
> ->use_gpio_descriptors() and also supplying their own
> ->set_cs() callback and expecting this behaviour, or the fix
> will have fixed broken a bunch of drivers.
> 
> But we are lucky: there aren't many of them.
> In addition to spi-cadence.c this seems to affect only spi-dw.c
> and I suppose that is what Gregory was using? Or
> something else?
> 

I will go do some digging and see what I can find.

Thanks,
Charles
