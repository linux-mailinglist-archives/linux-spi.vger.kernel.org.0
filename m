Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0EF21CFB2
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jul 2020 08:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgGMG3Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jul 2020 02:29:16 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:18533 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbgGMG3Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jul 2020 02:29:16 -0400
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id 06D5x0FB075717
        for <linux-spi@vger.kernel.org>; Mon, 13 Jul 2020 13:59:00 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from twhfmlp1.macronix.com (twhfmlp1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id 06D5wVAs075451;
        Mon, 13 Jul 2020 13:58:31 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id B08C44370D23BF98939D;
        Mon, 13 Jul 2020 13:58:31 +0800 (CST)
In-Reply-To: <1590737775-4798-7-git-send-email-masonccyang@mxic.com.tw>
References: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw> <1590737775-4798-7-git-send-email-masonccyang@mxic.com.tw>
To:     ycllin@mxic.com.tw
Cc:     boris.brezillon@collabora.com, broonie@kernel.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        matthias.bgg@gmail.com, miquel.raynal@bootlin.com, p.yadav@ti.com,
        richard@nod.at, tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: Re: [PATCH v4 6/7] spi: mxic: patch for octal DTR mode support
MIME-Version: 1.0
X-KeepSent: 82B441C6:DBA1A48E-482585A4:0020C734;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF82B441C6.DBA1A48E-ON482585A4.0020C734-482585A4.0020D2E6@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Mon, 13 Jul 2020 13:58:31 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2020/07/13 PM 01:58:31,
        Serialize complete at 2020/07/13 PM 01:58:31
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com 06D5wVAs075451
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


+ YC Lin in loop,

--
> 
> Subject
> 
> [PATCH v4 6/7] spi: mxic: patch for octal DTR mode support
> 
> Driver patch for octal 8D-8D-8D mode support.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---


CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================

