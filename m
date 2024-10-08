Return-Path: <linux-spi+bounces-5154-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E7B9955A4
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 19:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3981F226E9
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 17:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEB41FAC2A;
	Tue,  8 Oct 2024 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="gxtcQKzq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3926A1F9A9A;
	Tue,  8 Oct 2024 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408592; cv=none; b=QEe9OBY8+gLWcFZHfbvc/8lGGPu+WSBFeZ/WdApkSytqcjjhC+LRpKhKblFqs8Dn6hmvzhIAzz2E/vd1Q8BpPA/Cyb6o2JuiHVU6GBqokOAVN3GleH1AlVTnt57nBGJqsWqWNWqeCocfGujm+Vfl8NiZi0jGjYm9Ks39dge7r64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408592; c=relaxed/simple;
	bh=NZM6SrJOvtNdqkvO0uEifVK1D9iXc7qKHmPQbasET00=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pYcpJMlk+S+z0/C1jbU/lerA7HEdbM97txHFXJeu1Hhq1ECuuh26SQlDPeZdUwI6wenKi9+BE5OBrmgB2H3NPaY2b8ZlFPdy1BhWQcD4s5ScE3XN9ybxH80AbkeTx6vqp+xmUbGwzGTwETsBp7b0MyqefTnpCmT7wq+sujhdEn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=gxtcQKzq; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728408587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AYFhlZBQl30d0/K1Ing+FBJNjRss/IOlkrpTJ/fuidg=;
	b=gxtcQKzqZ9QlhTpiLrVhbI4Fha7eEuCxXuwfs3nFN9/ZRd8prRv7u2vdu5q7GiXCJEWq+y
	S1+x/Ob1GMDG2iys2rcwz9yQvespzkA/0Vzc+CmAJUDYFf1wcVsbOpCjFgsLYQ7FFnvxqg
	XLDBSxPkfunmx2tjgwMgyJau/gQPXWj6yejkBsKaLv6K80KmcoGKrSD+nJCyJSsxZWL3jY
	ogzSDmTWwDsRTb8SvcrF5+a0ZOfPV0Wy+nz/NV7F1YYQxTY5Wai8i1CcRc6zJRLv24SHk2
	HwrAqY2jnk038aQXfIAFDp3/5U6hDzMBaEHOA0j8MaEZEQxaos5+ACsZugMxPQ==
To: linux-spi@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Cc: broonie@kernel.org,
	heiko@sntech.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	oss@helene.moe,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: Fix a typo in __dev_probe_failed() comments
Date: Tue,  8 Oct 2024 19:29:41 +0200
Message-Id: <cec37f5568afaef8fca2d35bb01c90556ccbb4f4.1728408464.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Fix a small typo in one of the variable names found in the comment block
inside the __dev_probe_failed() function.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    This is an incremental patch for the patch series [1] that's been already
    merged, so it should be applied on top of the series.
    
    [1] https://lore.kernel.org/linux-rockchip/cover.1727601608.git.dsimic@manjaro.org/T/#u

 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5f156a9a10a4..a84a7b952cfd 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4989,7 +4989,7 @@ static void __dev_probe_failed(const struct device *dev, int err, bool fatal,
 	/*
 	 * On x86_64 and possibly on other architectures, va_list is actually a
 	 * size-1 array containing a structure.  As a result, function parameter
-	 * vargps decays from T[1] to T*, and &vargsp has type T** rather than
+	 * vargsp decays from T[1] to T*, and &vargsp has type T** rather than
 	 * T(*)[1], which is expected by its assignment to vaf.va below.
 	 *
 	 * One standard way to solve this mess is by creating a copy in a local

