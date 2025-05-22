Return-Path: <linux-spi+bounces-8236-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E839AC0A28
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 12:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055DA1BC2025
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 10:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5C6288535;
	Thu, 22 May 2025 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2XZBffpV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1430289E11;
	Thu, 22 May 2025 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747911450; cv=none; b=lBhMnHE+m5+pio7hQpfVA+n/LXDsHhJhuwwJmiTsnSkVHV45Dzzpa5qimWTUfaRiJZI5UPe+EMvQ+uI2TSK0HMtqUj5fxRVyjDXAEIwxoAHKXxe9TVoSnYg8D0sq+LqCgySiwzRZL0nhbx3f9tciuJ+T53UwvRdJ+72Og5JDhHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747911450; c=relaxed/simple;
	bh=/w2C647Ki1Ko/omjghXi8LGBFeBgUweyzHfDIxNLXoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NVwmwqjWP/R7fgt174vsn8zQQGbS1xx9POpyNy82tLoKFoEdcLXeufWaVdyNNZ2vLpluLVqJhqzgOjaxvYdxSsalGLluE96udIrn6Mv46fQeu1EJNOt9x+dpDQUvILOL/APOzaMq7GZRC6hLWcGC+cDMxunijv/RRvffFoNS1ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2XZBffpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB53C4CEED;
	Thu, 22 May 2025 10:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747911450;
	bh=/w2C647Ki1Ko/omjghXi8LGBFeBgUweyzHfDIxNLXoE=;
	h=From:To:Cc:Subject:Date:From;
	b=2XZBffpV30J0Onf55Twmzqk+YpDldKg0KzeOvia+dFe80KUE/yzQcWxszNXatz6LK
	 nTVV2rdmRaiIAuPAKsdtadRGQrdeJgyWwioVf2j1dp0rmiz6a7tnw7kQ/8wUB1dc//
	 RpAYU1r3o2GhLh+Ut56eIMFqYQpL9xs3JYg3E2O0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: gpio: fix const issue in spi_to_spi_gpio()
Date: Thu, 22 May 2025 12:57:26 +0200
Message-ID: <2025052225-scallion-ritzy-dbbd@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 31
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=/w2C647Ki1Ko/omjghXi8LGBFeBgUweyzHfDIxNLXoE=; b=owGbwMvMwCRo6H6F97bub03G02pJDBn6zGJ/5EpTgpf+kRC5sPDUaz/75tmzFn39xLyzss3HN 2+n68aejlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZhIaCzDPJNYs3h2u8iPoQ8y 7IL7Nfmlrdv/Miw4G8A8t5t1/v9TbovU/i0Nk5+4pvAlAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

While the struct spi_device * passed into spi_to_spi_gpio() is a const
one, the struct spi_bitbang * that is retrieved from the controller
field in the spi_device is NOT a const pointer, as it is coming from the
spi_controller_get_devdata() call, and then passed to container_of()
which would strip off the const attribute for no good reason (i.e. if a
const pointer is passed to container_of() it still is const coming out).

Fix this all up by properly declaring the struct spi_bitbang * as not
const.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 405deb6677c1..ea5f1b10b79e 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -46,7 +46,7 @@ struct spi_gpio {
 static inline struct spi_gpio *__pure
 spi_to_spi_gpio(const struct spi_device *spi)
 {
-	const struct spi_bitbang	*bang;
+	struct spi_bitbang		*bang;
 	struct spi_gpio			*spi_gpio;
 
 	bang = spi_controller_get_devdata(spi->controller);
-- 
2.49.0


