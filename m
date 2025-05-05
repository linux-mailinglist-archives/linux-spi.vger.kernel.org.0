Return-Path: <linux-spi+bounces-7905-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D23AAA18E
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 00:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C6D1A84E5E
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 22:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACD62BF3F6;
	Mon,  5 May 2025 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j056Flnx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A242BEC2B;
	Mon,  5 May 2025 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483596; cv=none; b=VvtVtlG58oQTCJnEk7JevR2xFLMCRdt4iFp5AB19WeUpKskpUfDOi0r80vYWXiBP4lGsamBYypN6kN3fydEcOFzXwpMRtKG9hXOMkOWuzYQhcXnDTk8j27wakZ+j/dXpNCzwaUaU4Id4PjqgPZn2XWnz11UDK83ht46UeYkrcLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483596; c=relaxed/simple;
	bh=kjAsViGtHjStfVoskh40kOGVqPEkltRf6p3137feQjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JjgdbZHrneLM1+V9u+Xm1j4LLeKIG0aycIO6bsTxSnfUGQxfSvl7PwkPjswRw02QSx2Z3YMhDJri5DuonadthVuIm65+u6KNB98hEmjuBGO4XMv0Sbcj5MhXH1NZoawDn9WC8C7ir3Rm3JXi39Ig5799nC6UaMGBWQoVXIclTiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j056Flnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2E6C4CEEE;
	Mon,  5 May 2025 22:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483596;
	bh=kjAsViGtHjStfVoskh40kOGVqPEkltRf6p3137feQjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j056FlnxeuPWBrET5K0jRguAWMGcmD+44uDFPnfCGonTlmppgLPpGgZ/g8IHBPMUX
	 YVTVv/DbAVEtOSDPO8VbOgFNM5KGwARO43VXCbXI1GkUlJ54iJAzo0rXwTPOLqe9ZZ
	 quEreEA/a/F8RvDIJRNG5vYsWtI3eHagPgpiexMeUn9+8ApxmpgabN52KVRh6dwxWU
	 TFJHVV9oaevbKpedeiQU6k4lbK4e6e1dza9H89pZlyNVlq+cGVDEoxqN+81wRj/7Ev
	 3SUeaJBqNBJMfkPkYpWNuAkYl2JySwp0i/uPmbXqcdQBoI/Fkp7liuWS8dmYuk/O/T
	 PeZQlekiA4vqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sergio Perez Gonzalez <sperezglz@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 135/642] spi: spi-mux: Fix coverity issue, unchecked return value
Date: Mon,  5 May 2025 18:05:51 -0400
Message-Id: <20250505221419.2672473-135-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Sergio Perez Gonzalez <sperezglz@gmail.com>

[ Upstream commit 5a5fc308418aca275a898d638bc38c093d101855 ]

The return value of spi_setup() is not captured within
spi_mux_select() and it is assumed to be always success.

CID: 1638374

Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
Link: https://patch.msgid.link/20250316054651.13242-1-sperezglz@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-mux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index c02c4204442f5..0eb35c4e3987e 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -68,9 +68,7 @@ static int spi_mux_select(struct spi_device *spi)
 
 	priv->current_cs = spi_get_chipselect(spi, 0);
 
-	spi_setup(priv->spi);
-
-	return 0;
+	return spi_setup(priv->spi);
 }
 
 static int spi_mux_setup(struct spi_device *spi)
-- 
2.39.5


