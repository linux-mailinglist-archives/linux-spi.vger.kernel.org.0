Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE46325888
	for <lists+linux-spi@lfdr.de>; Thu, 25 Feb 2021 22:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhBYVUi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Feb 2021 16:20:38 -0500
Received: from gloria.sntech.de ([185.11.138.130]:43762 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233242AbhBYVUh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 25 Feb 2021 16:20:37 -0500
Received: from [95.90.166.74] (helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lFO2n-00059G-1g; Thu, 25 Feb 2021 22:19:33 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Mark Brown <broonie@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jon Lin <jon.lin@rock-chips.com>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Alexander Kochetkov <al.kochet@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] spi: rockchip: avoid objtool warning
Date:   Thu, 25 Feb 2021 22:19:32 +0100
Message-ID: <5587539.MhkbZ0Pkbq@diego>
In-Reply-To: <20210225125541.1808719-1-arnd@kernel.org>
References: <20210225125541.1808719-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am Donnerstag, 25. Februar 2021, 13:55:34 CET schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building this file with clang leads to a an unreachable code path
> causing a warning from objtool:
> 
> drivers/spi/spi-rockchip.o: warning: objtool: rockchip_spi_transfer_one()+0x2e0: sibling call from callable instruction with modified stack frame
> 
> Use BUG() instead of unreachable() to avoid the undefined behavior
> if it does happen.
> 
> Fixes: 65498c6ae241 ("spi: rockchip: support 4bit words")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/spi/spi-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index 936ef54e0903..972beac1169a 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -521,7 +521,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
>  		 * ctlr->bits_per_word_mask, so this shouldn't
>  		 * happen
>  		 */
> -		unreachable();
> +		BUG();
>  	}
>  
>  	if (use_dma) {
> 




