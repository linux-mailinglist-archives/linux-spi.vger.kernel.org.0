Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62ED2B0441
	for <lists+linux-spi@lfdr.de>; Thu, 12 Nov 2020 12:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgKLLrn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Nov 2020 06:47:43 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:10250 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728201AbgKLLlw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Nov 2020 06:41:52 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ACBd5pe021048;
        Thu, 12 Nov 2020 05:41:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=j/1abh6t7YrrzXU1SesVqlhurYOExGuzAxH/2JLe2ws=;
 b=E6gdlPIyElcjoqqMFHiI7N2SUDwd0NEVIJ9pQdaud6Al7tw8inWp8UDSv4irRqaS54Wp
 p1Swh03GraIF3TM9yZH9JbhvdfAI+KhTwS8WeCmPdtU0mjiYrT6YOPNazoedsIDg4pEt
 dhSSHWY7L7bsTujScVFKcgiUFdZwJHIhBcqBIwZZPIgiOH86IE0CwtRcnymRRPuc5xNT
 EcyS7hfqrXJq9WHheHBH1d79iowXh8N7mYEIH2ZdrpWCPoTnQuoY41A56uKoc6lzBYGI
 8TFlYsAzGSz9fQ9+zUrz0OlChjc5Wrob+tK8g53FiRYTEWH9kArxv3vUHtyoBOpOVijw Ig== 
Received: from ediex02.ad.cirrus.com ([5.172.152.52])
        by mx0a-001ae601.pphosted.com with ESMTP id 34rn2yh5q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 05:41:38 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 12 Nov
 2020 11:41:36 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 12 Nov 2020 11:41:36 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 88F877C;
        Thu, 12 Nov 2020 11:41:36 +0000 (UTC)
Date:   Thu, 12 Nov 2020 11:41:36 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
CC:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Simon Han <z.han@kunbus.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] spi: fix client driver breakages when using GPIO
 descriptors
Message-ID: <20201112114136.GE10899@ediswmail.ad.cirrus.com>
References: <20201106150706.29089-1-TheSven73@gmail.com>
 <160510968064.12304.14797288117651443603.b4-ty@kernel.org>
 <CAGngYiVAdPSCEQm5pJdFQ+3VpwNH1vGD6rPNK1_SQK3Uvfbt5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGngYiVAdPSCEQm5pJdFQ+3VpwNH1vGD6rPNK1_SQK3Uvfbt5A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0
 malwarescore=0 clxscore=1011 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120069
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Nov 11, 2020 at 11:24:14AM -0500, Sven Van Asbroeck wrote:
> On Wed, Nov 11, 2020 at 10:48 AM Mark Brown <broonie@kernel.org> wrote:
> >
> > Applied to
> >
> >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thank you !
> 
> Now that our minds are still focused on this subject, should
> commit 138c9c32f090 ("spi: spidev: Fix CS polarity if GPIO descriptors
> are used")
> be reverted?
> 
> This fixed spidev to deal with SPI_CS_HIGH on gpiod.
> But after our fix, its behaviour will probably be broken again.
> 
> Another candidate for revert is
> commit ada9e3fcc175 ("spi: dw: Correct handling of native chipselect")
> although I don't understand that code well enough to be sure.
> 
> Adding Charles Keepax.

Looks like the code has changed a fair amount since my patch. The
important detail from it was trying to clarify the semantics of the
controller->set_cs callback. That function is called with a boolean
argument and that argument could have two possible meanings:

1) True means apply a high logic level to the chip select line.
2) True mean apply chip select.

Under interpretation 2) the chip select line would be set to a
different logic level depending on if the device is active high or
active low.

If I remember correctly at the point of my patch the core had just
changed between the two a couple of times but now consistently did 1)
(and looks like it still does), my patch intended to updated the
spi-dw driver to match that, as my SPI had stopped working. I think
it then turned out, my patch broke some other use-cases and that
the bit in the IP basically had 2) semantics in hardware. Which is
what this patch fixed:

commit 9aea644ca17b ("spi: dw: Fix native CS being unset")

After that patch my patch is mostly replaced so I don't think it
would make any sense to revert my patch at this point, and I
don't think your patch will break the spi-dw driver. I don't
have easy access to the hardware right now to test, but I will
give it is quick run when that option becomes available to me
again.

Your fix looks good to me, but I suspect you do need to fix the
spidev stuff although I have haven't looked at that in detail.

Thanks,
Charles
