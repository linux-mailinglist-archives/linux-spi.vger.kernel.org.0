Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F482397375
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jun 2021 14:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhFAMql (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Jun 2021 08:46:41 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:41279 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbhFAMqk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Jun 2021 08:46:40 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8735722236;
        Tue,  1 Jun 2021 14:44:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1622551498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b43l9JwGMojnvxR7u6rb4bHE+y8B1xgeuP6UyhnRg5c=;
        b=rNrxYXXV2kN3d7v6g8tdreG6grSr43AMWyyJiXRAN9wHYI7ylyOnvcu3RMCODE/vVAQgxk
        Hibh6sxO6fBla+TpjAkb4hR658JUgaTvrByCl2UMuJxUp4jeiyZ2ngu/tk0Z7wyDTdNIYh
        0fF8pYRGkd4I7NJq9uFUwXwFw3Ab4oc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Jun 2021 14:44:57 +0200
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 6/6] mtd: spi-nor: core: avoid odd length/address
 writes in 8D-8D-8D mode
In-Reply-To: <20210531181757.19458-7-p.yadav@ti.com>
References: <20210531181757.19458-1-p.yadav@ti.com>
 <20210531181757.19458-7-p.yadav@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <6fb69565f7b27eb7e8ee3321624ad624@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2021-05-31 20:17, schrieb Pratyush Yadav:
> On Octal DTR capable flashes like Micron Xcella the writes cannot start
> or end at an odd address in Octal DTR mode. Extra 0xff bytes need to be
> appended or prepended to make sure the start address and end address 
> are
> even. 0xff is used because on NOR flashes a program operation can only
> flip bits from 1 to 0, not the other way round. 0 to 1 flip needs to
> happen via erases.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

Reviewed-by: Michael Walle <michael@walle.cc>
