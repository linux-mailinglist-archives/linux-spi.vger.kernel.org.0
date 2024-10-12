Return-Path: <linux-spi+bounces-5205-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC45B99B2AE
	for <lists+linux-spi@lfdr.de>; Sat, 12 Oct 2024 11:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C55B283E41
	for <lists+linux-spi@lfdr.de>; Sat, 12 Oct 2024 09:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690ED1514CE;
	Sat, 12 Oct 2024 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qrrth7nF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93AB610D;
	Sat, 12 Oct 2024 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728726866; cv=none; b=WkOds66HvzY6qaTNPTtskmSezSBZhx7JmFo4dZkqsqXyrjk+XpIQHY/mbPBX3C9W81x9ZrYZ3VjOUnHJYt4y5wsVsVcJgAZz6vCYCZ9hI3C7QEIDXt3FYKYZTM45dM4X7XJkWPhPWsqd7jeWdGinm7We9d7B2VQM74dPen1+9mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728726866; c=relaxed/simple;
	bh=TfawiNnYj5zNLv+jVcmBc+6b6S3nRECwPwGfhLaSrzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qd830aEkz2BoTQ4PVwZ9CJSmkJAIv+mMO7WupxUz7Mzb8R3lrbcnsKddv7GsPQWiZDk7iYEUyisTVskv1kiWLR59u1qZszzZfwCiza0Cs9fsr7jTB+WJ4Y3dp6uzAUiJ5yM+aNaag67tz8YIVc6Gvfqt6IAej+OO8AguZsh/FlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qrrth7nF; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99f646ff1bso12117666b.2;
        Sat, 12 Oct 2024 02:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728726863; x=1729331663; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8ZC9ITCPhenAYf/vv6uhGh5WumL2pziZ+L10pLWJTM=;
        b=Qrrth7nFem0y6gHUgoyr4KXK9gW1tE8HPTEJrR+PJGpfGypoBo32/1SRQvV1R3QAsS
         Y4W9VoMMwO1Rrtl/zLIe+pcgxGT5lGbIKQ16UJNq6z89ZtDl9wfBJv8aFrbkxinbfSXk
         92PPTqJ81zgHa4MqI7NX+EGLgkT8fqv83VCLuJLrigtBhkPGh90iP5Yv96435VVShPXZ
         L+Lo/HJlAC/uW74pfng0TXP/N1pLCw5sjYoLmeJ75O9zUN9a2JQ9QdF1P49YNsRQYsM4
         tD6oq8joFr9lkhFrTj7VRewhwM3BRRp1mr4qvwxEiQr2httWWPWqwLrQeLbQ34dwdzWS
         I4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728726863; x=1729331663;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8ZC9ITCPhenAYf/vv6uhGh5WumL2pziZ+L10pLWJTM=;
        b=bKqJMolylAbcyNW+WIrGiGvzzEN+01mwWMpiMWBf6CHiMRSsUfd35kB01dKN9LQvSb
         XhFM9eVWrgjRuEYZ62tdZ+lBxMwZyocZremaRntDnJrmlcUoQ+c2Gh881SYJ62LDD7uh
         XXR+NRnZvFbWKEeE/Ml8Qzz0E83JNzASUpgOIGX19n3vB1SUkAAiVREn9Z9kgjp0I65H
         AavfMoLnOFhGDJfGYpVPcI/dHs9F7qCtPl55VRTm4/3Zm2nbg4VTCPeAtkBwO5KIRTn7
         ObcfSsD4c095sO1nRUF81iOMeKwVjmJDCmv9kK7xibmNQuxtWd7ZbIYf6z7RMb4Yu7+t
         vzTg==
X-Forwarded-Encrypted: i=1; AJvYcCV4P9kkIBe9pEIQiOtLbDol/79glWvYmSGAueJmfeKN15Nk06/M2Mej32RBAMkhVHIE/GQHXJzzxn7HKOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYSTPoUi5CjKv/AKZJd755BkqMomEjGY6U6g1vGso96L5GCUEu
	bb++fESAJfzlmzTmfABaeaSL6wiJzsJHIJ/ixG9NiEBMbVBNsztvBHPsQpZ8v80=
X-Google-Smtp-Source: AGHT+IEhaqnA7LkNOsegegkcVESQ2FBN7VOw9DUl/+LSCE2rE4OAG0X1A4zwpgwynNerFXfpeqoRFA==
X-Received: by 2002:a17:907:2cc3:b0:a8d:3338:a497 with SMTP id a640c23a62f3a-a99b93239f6mr488486566b.4.1728726862748;
        Sat, 12 Oct 2024 02:54:22 -0700 (PDT)
Received: from localhost (dslb-002-200-173-220.002.200.pools.vodafone-ip.de. [2.200.173.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80efe57sm308258366b.188.2024.10.12.02.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 02:54:22 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sat, 12 Oct 2024 11:53:35 +0200
Subject: [PATCH 1/6] spi: fix return code when spi device has too many
 chipselects
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-spi_multi_cs_cleanup-v1-1-dc491113880d@gmail.com>
References: <20241012-spi_multi_cs_cleanup-v1-0-dc491113880d@gmail.com>
In-Reply-To: <20241012-spi_multi_cs_cleanup-v1-0-dc491113880d@gmail.com>
To: Mark Brown <broonie@kernel.org>, 
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Don't return a positive value when there are too many chipselects.

Fixes: 4d8ff6b0991d ("spi: Add multi-cs memories support in SPI core")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7c5e76b154212585af1c3893005cb353a0eaeafc..ab38978e9c58517bb671d7bda017c8550cc82d58 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2452,7 +2452,7 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	if (rc > ctlr->num_chipselect) {
 		dev_err(&ctlr->dev, "%pOF has number of CS > ctlr->num_chipselect (%d)\n",
 			nc, rc);
-		return rc;
+		return -EINVAL;
 	}
 	if ((of_property_read_bool(nc, "parallel-memories")) &&
 	    (!(ctlr->flags & SPI_CONTROLLER_MULTI_CS))) {

-- 
2.43.0


