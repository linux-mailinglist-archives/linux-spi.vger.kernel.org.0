Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3488E39735A
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jun 2021 14:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhFAMiL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Jun 2021 08:38:11 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:55921 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbhFAMiL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Jun 2021 08:38:11 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7214222236;
        Tue,  1 Jun 2021 14:36:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1622550988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KbCr62UBWzd91uPGhP19/e09ZyrN+lS6g3DQdq64C/A=;
        b=DN6N48S0t7BUy1ObG3XMDfSA+JSidH0Pet1iGzTVl/ITZ1mOik8TV+mZvxe5mw9NlrHi5r
        JyZ882Z4uCKn5v1ZFBnQVfLUehdWVE5GZOS0Z35Lz999CanT3O3Yw8dSz36x4N1Z7xba70
        l2zgKKY6GjVHld5Sj00fW0xdwNRH7vI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Jun 2021 14:36:28 +0200
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 1/6] mtd: spi-nor: core: use 2 data bytes for template
 ops
In-Reply-To: <20210531181757.19458-2-p.yadav@ti.com>
References: <20210531181757.19458-1-p.yadav@ti.com>
 <20210531181757.19458-2-p.yadav@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <543350e0bc25f84a0ba9f464dcfa15bf@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2021-05-31 20:17, schrieb Pratyush Yadav:
> The template ops used in spi_nor_spimem_check_pp() and
> spi_nor_spimem_check_readop() currently set the data phase to 1 byte
> long. This is problematic for 8D-8D-8D protocol where odd length data
> phase is invalid since one cycle transfers 2 bytes and odd number of
> bytes would mean half a cycle is left over. This could result in a
> controller rejecting the op as "not supported" even though it actually
> supports the protocol.
> 
> Change the data length to 2 bytes in these templates. One might argue
> that this should only be done for 8D-8D-8D operations but when talking
> about these templates, there is no functional difference between one 
> and
> two bytes, even in STR modes.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---

Reviewed-by: Michael Walle <michael@walle.cc>
