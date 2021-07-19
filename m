Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9033CCFD0
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jul 2021 11:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbhGSIU4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Jul 2021 04:20:56 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:35674 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235646AbhGSIUw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Jul 2021 04:20:52 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16J6UDsr031145;
        Mon, 19 Jul 2021 04:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=rnbfIW071Bte8vBBd+4i4gohnxa1lDyV8t94p2R8Y5U=;
 b=X7eWghu4BT0X7EFlyAu7EXiqF6VmOHHFIdFRnvEt8wx12ZczgF+zLL+aP3kLIoAJJDFv
 SotgxCrfBqUSmru9adGSigRw29Rio+T0ztJs9Y4zWOHHnWOMDctIuJboWmS03z98j0gV
 1eRfNmEr9SP3ptyZsPY4qiJ6cpBsATu4OUcovwBF+OJSg9PEE4Yn3Pc+u97Tlr4LgyWg
 GzrP6xAVTan6U+cUYRkdnm9Sd92uPI6ZFfNDbT6A0+HHK0AAQjnQpBITxF339mm6GpeV
 2Z1KYhQZr3GQWUdu6SP5tfHvuW05n7Nf6Ktq988DnQdRxQ7lRCOjK845+eZW/z1JUKXY Kg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 39vwa5rdrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 19 Jul 2021 04:01:26 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 10:01:24 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 19 Jul 2021 10:01:24 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D76082BA;
        Mon, 19 Jul 2021 09:01:24 +0000 (UTC)
Date:   Mon, 19 Jul 2021 09:01:24 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Marek Vasut <marex@denx.de>
CC:     <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: cadence: Correct initialisation of runtime PM again
Message-ID: <20210719090124.GI9223@ediswmail.ad.cirrus.com>
References: <20210716182133.218640-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210716182133.218640-1-marex@denx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: Csvwm-m-TMmE7ZrGGawLoRmp4ycnkSFY
X-Proofpoint-GUID: Csvwm-m-TMmE7ZrGGawLoRmp4ycnkSFY
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107190050
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jul 16, 2021 at 08:21:33PM +0200, Marek Vasut wrote:
> The original implementation of RPM handling in probe() was mostly
> correct, except it failed to call pm_runtime_get_*() to activate the
> hardware. The subsequent fix, 734882a8bf98 ("spi: cadence: Correct
> initialisation of runtime PM"), breaks the implementation further,
> to the point where the system using this hard IP on ZynqMP hangs on
> boot, because it accesses hardware which is gated off.
> 
> Undo 734882a8bf98 ("spi: cadence: Correct initialisation of runtime
> PM") and instead add missing pm_runtime_get_noresume() and move the
> RPM disabling all the way to the end of probe(). That makes ZynqMP
> not hang on boot yet again.
> 
> Fixes: 734882a8bf98 ("spi: cadence: Correct initialisation of runtime PM")
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Cc: Mark Brown <broonie@kernel.org>
> ---

For my own edification do you know exactly what the problem was
on your system here? I am assuming my mistake was that without the
pm_runtime reference being taken, some required parent doesn't get
enabled, which is convienently fine on my Zynq but not your ZynqMP?

The inclusion of the IRQ stuff in the pm_runtime block makes me a
little nervous as if the problem is that your hardware generates
a spurious IRQ on boot and that is where the bad access comes from
this code feels racy. The original code did the put before the IRQ
registers as well.

All that said, works on my Zynq:

Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
