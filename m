Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE74431949C
	for <lists+linux-spi@lfdr.de>; Thu, 11 Feb 2021 21:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhBKUiB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Feb 2021 15:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhBKUh7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 Feb 2021 15:37:59 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EE3C061788
        for <linux-spi@vger.kernel.org>; Thu, 11 Feb 2021 12:37:19 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gx20so4109532pjb.1
        for <linux-spi@vger.kernel.org>; Thu, 11 Feb 2021 12:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9BHuk3ZYMLLx5jkh2jfjNl/0+0DOqtjeK6vm2BoIWLM=;
        b=LTxtqY4r6M08Z++xlLlEFgEpj9xnOLzNb2VDxxPGPfaXYDd3hebnYLucoMv+4K3gZf
         b238WdzxH+CwSavS1QG1gSIset8fIziXAmNEGRm8WcBhHZIc8YqF4r0cySYF0UC91O71
         jQ6RHwAtVQDykw7pe64D2Kdt4hNuWSgI8fziY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9BHuk3ZYMLLx5jkh2jfjNl/0+0DOqtjeK6vm2BoIWLM=;
        b=JBs/dVJMf/o2TFCzScBOrLbpbwdB4Dha/asKr4XMA9mOz5LE1CWDJi+rC5aIXQLbUQ
         VW3RLo9yCtKP6z7SFoCU38o9fJfJtriePauttTYis9hbRQD4HMbgYrZiPQ2KuIvm6B4i
         kyNBZ7vd9WNJFgVSGkPY6IWeu6jluEc/Vl+Ixq9mc74/MVxyFLk9xe1+4Obtdm4Gk79H
         xSDiFhy99Vi8zq/dkYxiwC/KjL366G7kiklxmnPSMvWtrz5lUG0lo5hmhInxxWGqAt2U
         K9N0P26Dln8EhOtGcbY+r6lFA893ZVt5lQSvq0+PnnG7nFkmlaHRBk+612nPcayjKSU5
         dE2Q==
X-Gm-Message-State: AOAM531M3U4tB0xWsKQfi7YkAr/QmlET9boG0CwMWDwP0AH2zps5PnVG
        n0nsGHea2V5ARyHMP8mE0DXiIcWkvY3IWA==
X-Google-Smtp-Source: ABdhPJy4mCUr+FLNqbadedEOQ4Ml0HfxCmiOE1ccQ8KAD7UIlNx/XTmTLlNpxAd6je8BoCjpBiIL3w==
X-Received: by 2002:a17:90a:b26:: with SMTP id 35mr5576902pjq.104.1613075838848;
        Thu, 11 Feb 2021 12:37:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s1sm6009223pjz.42.2021.02.11.12.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 12:37:18 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-spi@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] spi: dw: Avoid stack content exposure
Date:   Thu, 11 Feb 2021 12:37:14 -0800
Message-Id: <20210211203714.1929862-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=c096925a3c8985c42f6bdce7c1dc78eabf32a678; i=ACsCAAtHySWi4/GyQJ4FPUqzRVqKGJseolXprmVqVo0=; m=ssMcO9+CE4ZCEW+w5qXFX6Gk6yDhsXYySpOVbzwhQXs=; p=4UX3omQoBN9kpGxRRn7MGtHp0PfSA3+8vaFM2wXCPcs=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmAllXoACgkQiXL039xtwCb2nA/9ER3 P8/seL8bh2p+NxuRip48LLX1pasXUciBYzdnQ2gykRsTcWSc74DMtIfQkvibEQwjVS7Fdk6tHg+la pWJAiy9KxO3RYWZiq2Bc42Bv0kITcvQkn9NAxUzmBRMuJzbEFp7lOErLuuPy1GJw9cIFfYDFZo3Ow ky0whXUtjbzVpeSL16pg7pRdJhFvnGguV7Dz+sShfopgUpBVdIW+/hfxhiHiMKhjxzxWQd97+4S6x 4543Ba1XY9ij/P66g9In4Q0pBT+/0C9xCBF+0QrAcW43zPlgzcFjiOdlYu4cxvrwd4Oc1maRihxy/ d7YtuBRnmM/28hzvwG0SkFzKpnOWWBS4aR5A54lVrncQp8csikHnrRh/R4s4Wyrypuhxmcc62FPwX 7o86BzsAzi+0ESiivTyHkPcP3+p4MjEjt/EMpPSJ6xlDoUWGirhLt+380ZiaDpEsUACHMIzvoWATK Oq4gW8T9HNWbYEPlMaQ3MF0Sr9Sj+SfJ7yFspxveplbW1PhG9IgYMGN31pkUFlNgkhSf/jpBIjDZr Ymhc8WMK3axbWNX7rzYiz0VfPBUse30A85+WVfzP0Dwv2lb+UdjHEQl9+f95vZAyAKZ3GS0tRgVbi zebE19BkoKQEhrL6E9yYaWWT36/73azQfHCrWPw++0aJVtPFj0ip/y4BgCh6Xa8E=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since "data" is u32, &data is a "u32 *" type, which means pointer math
will move in u32-sized steps. This was meant to be a byte offset, so
cast &data to "char *" to aim the copy into the correct location.

Seen with -Warray-bounds (and found by Coverity):

In file included from ./include/linux/string.h:269,
                 from ./arch/powerpc/include/asm/paca.h:15,
                 from ./arch/powerpc/include/asm/current.h:13,
                 from ./include/linux/mutex.h:14,
                 from ./include/linux/notifier.h:14,
                 from ./include/linux/clk.h:14,
                 from drivers/spi/spi-dw-bt1.c:12:
In function 'memcpy',
    inlined from 'dw_spi_bt1_dirmap_copy_from_map' at drivers/spi/spi-dw-bt1.c:87:3:
./include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset 4 is out of the bounds [0, 4] of object 'data' with type 'u32' {aka 'unsigned int'} [-Warray-bounds]
   20 | #define __underlying_memcpy __builtin_memcpy
      |                             ^
./include/linux/fortify-string.h:191:9: note: in expansion of macro '__underlying_memcpy'
  191 |  return __underlying_memcpy(p, q, size);
      |         ^~~~~~~~~~~~~~~~~~~
drivers/spi/spi-dw-bt1.c: In function 'dw_spi_bt1_dirmap_copy_from_map':
drivers/spi/spi-dw-bt1.c:77:6: note: 'data' declared here
   77 |  u32 data;
      |      ^~~~

Addresses-Coverity: CID 1497771 Out-of-bounds access
Fixes: abf00907538e ("spi: dw: Add Baikal-T1 SPI Controller glue driver")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/spi/spi-dw-bt1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-bt1.c b/drivers/spi/spi-dw-bt1.c
index 4aa8596fb1f2..5be6b7b80c21 100644
--- a/drivers/spi/spi-dw-bt1.c
+++ b/drivers/spi/spi-dw-bt1.c
@@ -84,7 +84,7 @@ static void dw_spi_bt1_dirmap_copy_from_map(void *to, void __iomem *from, size_t
 	if (shift) {
 		chunk = min_t(size_t, 4 - shift, len);
 		data = readl_relaxed(from - shift);
-		memcpy(to, &data + shift, chunk);
+		memcpy(to, (char *)&data + shift, chunk);
 		from += chunk;
 		to += chunk;
 		len -= chunk;
-- 
2.25.1

