Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D567039737C
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jun 2021 14:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhFAMs7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Jun 2021 08:48:59 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:56491 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbhFAMs6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Jun 2021 08:48:58 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9D5A922236;
        Tue,  1 Jun 2021 14:47:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1622551635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v/3YxyX+Ol081lsLNR+PQ0B+vmJYYqKxRHPUbEOofow=;
        b=RuJdqdfALJu7SASfKuKsUSVyIPOaiNgbbVjCQjbSn9oR86pzD+Nn8Cjo3An4+GI6LX6NCG
        YdDfaCBp/Rm6HZwSbxSLzqCyqu6SI3PfrNb5/dMEAH5tvoXqKMSQUnDDW0GV0WL3DI3HxI
        fS71hmVivc3y/VR4oEEoLlOvP6chNfI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Jun 2021 14:47:15 +0200
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 2/6] mtd: spi-nor: spansion: write 2 bytes when
 disabling Octal DTR mode
In-Reply-To: <20210531181757.19458-3-p.yadav@ti.com>
References: <20210531181757.19458-1-p.yadav@ti.com>
 <20210531181757.19458-3-p.yadav@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <f875025538713a005b1c18f8eb5c24c0@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2021-05-31 20:17, schrieb Pratyush Yadav:
> The Octal DTR configuration is stored in the CFR5V register. This
> register is 1 byte wide. But 1 byte long transactions are not allowed 
> in
> 8D-8D-8D mode. Since the next byte address does not contain any
> register, it is safe to write any value to it. Write a 0 to it.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---

Can't say much, because there is no public datasheet, is there?

But looks sane. Same for patch 3/6.
