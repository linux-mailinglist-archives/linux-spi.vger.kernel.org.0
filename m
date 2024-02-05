Return-Path: <linux-spi+bounces-1041-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D7D849AD2
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 13:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B28CB25B6D
	for <lists+linux-spi@lfdr.de>; Mon,  5 Feb 2024 12:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5D839FFA;
	Mon,  5 Feb 2024 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u5GkOHML"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D3A32C8E
	for <linux-spi@vger.kernel.org>; Mon,  5 Feb 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137134; cv=none; b=pyWZbq48wqbQjPckPsgvu8qQPsOJWBXhbNApjhWUobtpnVDDiJTxV6Q9JtOakDWqkj+zqnaCHRV9sx/FBWKSacXOH+cxTUoybX8JIrcLA7FqwGR5jXSpHJ5i/5kfwif4qSYE2OtajvA+OWVAP9nCcrCXKP+U1525bwoenZWc5hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137134; c=relaxed/simple;
	bh=bkpMwYn8nbOzpgIiboImEfaN66xWiWIf1hOKEtwBN3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJ8CoxV7YBWr7wtQMTXJ1gLEe5u20gVAJ3Z8e10Oz8zPGW/OEfptcln1wo1FFF3SqV4sG0kXlPEOlqhVtTTNfJDv+1G4VN/PQF+WkYYIkA6rQgvC8v/+EOGulGwKvkCe9knPuAaUD8LAa0BN3Gsx1fFaTnhhgRGymS1WoyF3JWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u5GkOHML; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fd280421aso15294075e9.3
        for <linux-spi@vger.kernel.org>; Mon, 05 Feb 2024 04:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707137131; x=1707741931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnMYlR6fQ0mQVONi00LlSkAABzsjAbHvknmZ+n/K3Yg=;
        b=u5GkOHML/lUnOxFnDqmxx1UakMn4WncdxbOWVD8cgoo+Bn0dQ3CZTG+z6rG6FcKyzE
         LfmNUbbFGHPjrJ2otkf3TEMJ9vZxxmfN77xQLErCeZXj8SLyziv7mWLLwPujwRFdhflW
         hX561e2sqjT103umPAy9cJNGFyCAVITxpZcdCNliD1K56GpoB+1zUq0j04p2lyI3vVBi
         LiQDJOkDDWekRMhD6lxlHuMta8ih6P0SBgjsUjy8dDX4/COJ9yZPdu10DJgXdKTdjVLh
         i/gY8qDEiOZtn+SU1HD9gcKvf3J+s7nNuXMLlLeUMmJaxLtEti6SlQk4szuzcHHYhsij
         9SjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137131; x=1707741931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnMYlR6fQ0mQVONi00LlSkAABzsjAbHvknmZ+n/K3Yg=;
        b=n0MrgPewwhCnQP6o3ivkX1FVAhcEAIKJSeT2EeovAxR+ejPr/gF7GZGm8xgbI9DWBh
         8D1nmjLLCnxcEBy/mTYL8RWR0HlFlwlf77IHs8YzTbUjDtnM3YM6ItGzUjzslcVcHmmo
         /eJ9GVuxa+KwWOjTLXEFzpTYPLkW7c/QfjhV+e7sPG8jlhYMIBO5Lds7gZQlMUN7Imjy
         OEiHsGj7SazF0Xci1KCBrne5njij5zV57HgBTF0qJL3W3D+zjTlDu3YO+DwII+5SOONK
         RumhUJ5j04T7NkLvhtPugQoJtAMEoHHduHMqhzA9ZN88fnMFeM4XbnqgDb2prusnjkG7
         Pmjw==
X-Gm-Message-State: AOJu0YwqvuXHKYvhRakWzO6FkIRQMLaFk92cIZmekJEOlzwMGSS16AGd
	FsKdKu6SVhctODCmbUlfPDBBeKiBsV1SPMEgUVA4GDyYPMdOjgZvptSMOwLrYL4=
X-Google-Smtp-Source: AGHT+IHh2/7KX6KKpvaNwnmk9gubBGVZ9ofeLerSnDyELk8DCSmaQzMWdOz1adXh+ZdWJvshWkpSGA==
X-Received: by 2002:a05:600c:3585:b0:40f:c234:1fcc with SMTP id p5-20020a05600c358500b0040fc2341fccmr4358107wmq.29.1707137131112;
        Mon, 05 Feb 2024 04:45:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXcXFLJy6cfNdvSiZapC8x0gY2p2hCeIf/v6F/VZuAJu2HP1lwRIRqcyrhUsMDxQiJ9h10Rszuh0YKKJXHLP4Y4qai7EYJnqdHc2Kcm2fNELedi2qdVc2nSGdVppMbXle4S+bJysxUzFnWoRD5oVwNbG4ig02R4mPkWLoqpL6N0RawwU7U+oq70BZJleN5TCYzhoAeDdVexwYbEg6qh/pcIL1Euw4mYDTDOa1Q8kZcufSB7BPaVy4Dq+6pAzd9Hgmdfm2oxXmOmkYriteNl+xq6ahR75w1JqoOG/qmTLGQgW7NVtrT+tt+/ju8W7oh2U/ZqUjPtvVfQ4qzvuHCBxOWE8lTJIrPFt9leSmy29qKNjrkOmtKhPs9XH6UxdBnGzxezV4qEQXa4VBkQpJIDt8C+KKSCUelzDRdT4bFxW3TGnQZoq/W0h98avBuzO0krl7TZ1+F4Tei77sEFQaVpSWJPSQ5l3959S0B+NO+tMXQYS1FdoOo31JNjWysPSA==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0033b35da384fsm3650812wro.33.2024.02.05.04.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:45:30 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 14/16] spi: s3c64xx: downgrade dev_warn to dev_dbg for optional dt props
Date: Mon,  5 Feb 2024 12:45:11 +0000
Message-ID: <20240205124513.447875-15-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240205124513.447875-1-tudor.ambarus@linaro.org>
References: <20240205124513.447875-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"samsung,spi-src-clk" and "num-cs" are optional dt properties. Downgrade
the message from warning to debug message.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 1b84f5fdebce..a103d9e125b1 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1109,14 +1109,14 @@ static struct s3c64xx_spi_info *s3c64xx_spi_parse_dt(struct device *dev)
 		return ERR_PTR(-ENOMEM);
 
 	if (of_property_read_u32(dev->of_node, "samsung,spi-src-clk", &temp)) {
-		dev_warn(dev, "spi bus clock parent not specified, using clock at index 0 as parent\n");
+		dev_dbg(dev, "spi bus clock parent not specified, using clock at index 0 as parent\n");
 		sci->src_clk_nr = 0;
 	} else {
 		sci->src_clk_nr = temp;
 	}
 
 	if (of_property_read_u32(dev->of_node, "num-cs", &temp)) {
-		dev_warn(dev, "number of chip select lines not specified, assuming 1 chip select line\n");
+		dev_dbg(dev, "number of chip select lines not specified, assuming 1 chip select line\n");
 		sci->num_cs = 1;
 	} else {
 		sci->num_cs = temp;
-- 
2.43.0.594.gd9cf4e227d-goog


