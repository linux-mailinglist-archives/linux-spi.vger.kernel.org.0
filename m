Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B746D1F1
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2019 18:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfGRQVf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Jul 2019 12:21:35 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:39303 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727767AbfGRQVe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 18 Jul 2019 12:21:34 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IGFrdN029373;
        Thu, 18 Jul 2019 18:20:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=AvBlOX1aAMndwD1rjimEhtxf+389A11U97y4vAzgGfA=;
 b=IqUh0TsabC6t4UVUgILGQJoOnGYPHB6A9sgdy0pQo0YpyX/k0K+8YOgbM62oj46PUEBJ
 VMHguLTLKZpuhT50f3d3RdXVGyF6kTjYCTSiuj7JCt62pTWtW+EftpVJO0uKnK5h3dgH
 uZnzPwTGIRwk8vdR15Qs1c5hol+P+o8kq7CP5JhemBuKrKvBzIHhJYsxKGT+Ddw/h21B
 j98b1HPDnN1ApI4H7+rkes6BE+l99ewV37Isjstx4PCWsvOfhcF/UXPKHt0mKp/gySQV
 tcRIFPIFRmwjG4O2rwT4RoGmyQ/Qp5JDAGIHxwJD/t+/cWs402vzqVLTHxAxLDMp4hFU QQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tsdeppqs2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 18 Jul 2019 18:20:54 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4439038;
        Thu, 18 Jul 2019 16:20:44 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DBBA9533C;
        Thu, 18 Jul 2019 16:20:43 +0000 (GMT)
Received: from lmecxl0912.lme.st.com (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 18 Jul
 2019 18:20:42 +0200
Subject: Re: [PATCH] dt-bindings: Ensure child nodes are of type 'object'
To:     Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-spi@vger.kernel.org>
References: <20190715230457.3901-1-robh@kernel.org>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <66b45e4e-31b1-f878-5042-2282a5e8334f@st.com>
Date:   Thu, 18 Jul 2019 18:20:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715230457.3901-1-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_08:,,
 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Rob

On 7/16/19 1:04 AM, Rob Herring wrote:
> Properties which are child node definitions need to have an explict
> type. Otherwise, a matching (DT) property can silently match when an
> error is desired. Fix this up tree-wide. Once this is fixed, the
> meta-schema will enforce this on any child node definitions.
> 
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-spi@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack. I will take this via the DT tree.
>

For pinctrl STM32:

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>

thanks

Alexandre

> Rob
> 
>
