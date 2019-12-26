Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70DA812A98F
	for <lists+linux-spi@lfdr.de>; Thu, 26 Dec 2019 02:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfLZBzi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Dec 2019 20:55:38 -0500
Received: from mx.socionext.com ([202.248.49.38]:50462 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbfLZBzi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 25 Dec 2019 20:55:38 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 26 Dec 2019 10:55:37 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 789B71800B2;
        Thu, 26 Dec 2019 10:55:37 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Thu, 26 Dec 2019 10:56:18 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 0A3624035C;
        Thu, 26 Dec 2019 10:55:37 +0900 (JST)
Received: from [10.213.132.48] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id D87D412044A;
        Thu, 26 Dec 2019 10:55:36 +0900 (JST)
Date:   Thu, 26 Dec 2019 10:55:36 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] spi: uniphier: Add SPI_LOOP to the capabilities
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <20191225180142.GD27497@sirena.org.uk>
References: <1577149107-30670-5-git-send-email-hayashi.kunihiko@socionext.com> <20191225180142.GD27497@sirena.org.uk>
Message-Id: <20191226105536.302C.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,
Thanks for your comment.

On Wed, 25 Dec 2019 18:01:42 +0000 <broonie@kernel.org> wrote:
> On Tue, Dec 24, 2019 at 09:58:26AM +0900, Kunihiko Hayashi wrote:
> > Add SPI_LOOP to the capabilities to support loopback mode.
> 
> >  	master->min_speed_hz = DIV_ROUND_UP(clk_rate, SSI_MAX_CLK_DIVIDER);
> > -	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
> > +	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
> > +			    SPI_LOOP;
> 
> I'd expect to see a matching change that configures the hardware
> in loopback mode when the driver is in SPI_MODE?  There's nothing
> in the existing driver.

I see. When doing loopback test using spi-loopback-test.c, I thought
'loop_req=1' option was needed, however, the controller doesn't need it.
We can ignore this patch.

Thank you,

---
Best Regards,
Kunihiko Hayashi

