Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31084A4BD2
	for <lists+linux-spi@lfdr.de>; Mon, 31 Jan 2022 17:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380272AbiAaQWg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jan 2022 11:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380291AbiAaQWJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jan 2022 11:22:09 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD425C061751
        for <linux-spi@vger.kernel.org>; Mon, 31 Jan 2022 08:21:59 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 68A316000A;
        Mon, 31 Jan 2022 16:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643646118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uc1Eq7dd+bPu9eTgNj2Aq3Z1Xxr+klUm263jpDGtk68=;
        b=Gg0TeOXQJ6VmQk0tHOxoqArgGS4C6JTDt44ReRAzEnUMhJbeKYo1KACDUKhgVpikqO5d5r
        FWkVu0Sc2YaxXTYv1n8CpME0mWUvT38sqGBPw9BQF1ZZtQ+BTBQdRYxNDTq8yLkGPLRDT8
        NJaD0i2HVlGNbHVf03waHkQWHfC4g2Rifzz461voOkdBGON+6/YgISg7GcjIpOEImvZ3TC
        BYmDuixNUuS6YgFxYrl46mZngGyUDQJXS9i7OygnvI6iZn0yf2si3EZmdSSuGmXvln5Yo/
        EKMt1XEWHfSWIBQmWJWpGDNJN6LXmhX0KyvwGa/OzqRacjuIolQbHsrkI+XltA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v10 11/13] spi: mxic: Create a helper to ease the start of an operation
Date:   Mon, 31 Jan 2022 17:21:54 +0100
Message-Id: <20220131162154.23715-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220127091808.1043392-12-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'b8043fa4e3ee9cfecf25e32d58e676762b9b0a75'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 2022-01-27 at 09:18:06 UTC, Miquel Raynal wrote:
> Create the mxic_spi_mem_prep_op_cfg() helper to provide the content to
> write to the register controlling the next IO command. This helper will
> soon be used by the dirmap implementation and having this code
> factorized out earlier will clarify this addition.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Link: https://lore.kernel.org/linux-mtd/20220104083631.40776-12-miquel.raynal@bootlin.com

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc.

Miquel
