Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8169A1EB4A1
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jun 2020 06:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgFBEhR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jun 2020 00:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgFBEhR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jun 2020 00:37:17 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB1FC061A0E;
        Mon,  1 Jun 2020 21:37:17 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k18so9483503ion.0;
        Mon, 01 Jun 2020 21:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=X6DyC5DaX+qxjNOVZ0Jw9ZwmxJAyCiGEub0Mra97SZc=;
        b=k/rfVYChDozuTCakYrl/ioNcRakc3AZkjOFmddUZy4oPvxCJQpD14kDWsEEpmhcOfY
         o8OAKi1MdxO3diVxVYxJL+Pcg7KyEWB1fnszrDDvUljlHgLcNvHq9DBuxtLoS8a8avun
         RZxKfMPm+gZWW7WUNaLpqhzJ4oshh7ztATOvLdXk+MMx5h1Wurdi8nzHUnjO8RayVxtj
         2D2OT2dtyJs1dA+doS4ihHH32NHhpIQgMeQ3+VH2E/ZWQQoPOM8TQ7hUPna9CDXXhsHb
         wUmZ5bHgfa/Az4pJ81MDaGQcipa7PRz0Y/c1fcqjHWagoFPSlPGDwlSdgAJfknu7M10W
         g5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X6DyC5DaX+qxjNOVZ0Jw9ZwmxJAyCiGEub0Mra97SZc=;
        b=MuDYHTYynwGh3c/4z+wvzMMZg8McM3U0VMy0n/jBYYmiu08hVGdGfGjMrsVpLWKRvT
         9lXiy1LRhh/KMI2eP2TUcfiow28o+42KYQ582InsP9AUOk0N9cjqpikQvpUWE/Zt4jl4
         cHcprMkpLPr+y5lDNKC9h3qMbUuvRFbc3fhcRWQt6p7zV3gkvFFS7aq19sGWbIN3ccCr
         NTtxTP+QVE8RHR6o0eU57a2bv9cgfYcxJOoAdqObndklfcP79s/qkwRpABI4j9bGfZph
         KTPrAzYUKMUkkGs93jPR0CFOG771nYo7HUQcJK8uILqWA+qTGChdzag7sVrz/epiPMEX
         J+1g==
X-Gm-Message-State: AOAM533ZKCUNHFujHlxOMOcGvJlulD7G0DnzT4ZOFhKGoN3mTN56uMvm
        16Ir7+G8wp96hKvTosstBLQ=
X-Google-Smtp-Source: ABdhPJwqMtNiFsr5gmVBhnlgsQbaOHC75vORCQ2GLsTvDp7CUO8o1Wx5cGHYhl0JW5X5SNaiZ6CG0Q==
X-Received: by 2002:a05:6602:2e05:: with SMTP id o5mr21889998iow.28.1591072636458;
        Mon, 01 Jun 2020 21:37:16 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id z4sm837510ilm.72.2020.06.01.21.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 21:37:15 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] spi: spi-ti-qspi: call pm_runtime_put on pm_runtime_get failure
Date:   Mon,  1 Jun 2020 23:36:37 -0500
Message-Id: <20200602043637.5317-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The counter is incremented via pm_runtime_get even in failure case.
To correct the counter call pm_runtime_put in case of failure, too.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/spi/spi-ti-qspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 366a3e5cca6b..dfb811c5ef76 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -174,6 +174,7 @@ static int ti_qspi_setup(struct spi_device *spi)
 
 	ret = pm_runtime_get_sync(qspi->dev);
 	if (ret < 0) {
+		pm_runtime_put_autosuspend(qspi->dev);
 		dev_err(qspi->dev, "pm_runtime_get_sync() failed\n");
 		return ret;
 	}
-- 
2.17.1

