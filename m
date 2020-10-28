Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B730429D300
	for <lists+linux-spi@lfdr.de>; Wed, 28 Oct 2020 22:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgJ1Vj6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Oct 2020 17:39:58 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:43888 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbgJ1Vjr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Oct 2020 17:39:47 -0400
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 9AB9E3B46CD;
        Wed, 28 Oct 2020 17:14:36 +0000 (UTC)
X-Originating-IP: 83.193.246.53
Received: from windsurf.home (lfbn-bay-1-165-53.w83-193.abo.wanadoo.fr [83.193.246.53])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 712721C000C;
        Wed, 28 Oct 2020 17:14:13 +0000 (UTC)
Date:   Wed, 28 Oct 2020 18:14:12 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v2] serial: max310x: rework RX interrupt handling
Message-ID: <20201028181412.2ce77875@windsurf.home>
In-Reply-To: <20201028180651.50ca85d3@windsurf.home>
References: <20201001074415.349739-1-thomas.petazzoni@bootlin.com>
        <3841e43b-5f16-4b5c-9b43-4d3a90e57723@cesnet.cz>
        <20201028180651.50ca85d3@windsurf.home>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

On Wed, 28 Oct 2020 18:06:51 +0100
Thomas Petazzoni <thomas.petazzoni@bootlin.com> wrote:

> On my way to send a v3 :-)

Well, in fact the patch is upstream already:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/tty/serial/max310x.c?id=fce3c5c1a2d9cd888f2987662ce17c0c651916b2

So I'll send a follow-up patch instead.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
