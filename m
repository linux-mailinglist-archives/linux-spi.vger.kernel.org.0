Return-Path: <linux-spi+bounces-8145-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A8EAB909E
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 22:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB9B3A6422
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 20:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F278283FEE;
	Thu, 15 May 2025 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEFA3tw7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A309C27F75F;
	Thu, 15 May 2025 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747340019; cv=none; b=HH/CxaGOutkgs/Wvjan/AEe+2E6yQnMHNAyRS1RK7y5SJA/Ll8kqijx2xXN18MIbQZaETT9ZkeFDK7LJ4X37gQGPUdbtlPn7ymvE9udPRmtP+XYGpvEahtrbtnxZ0Dm5Ey4T38dMplXnhbxjh3ipv7yavG7yQVWp5Jzxv/Jf/08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747340019; c=relaxed/simple;
	bh=ylgYcjlgh9rGDFe8987LAqtE0I8aoviICsthulq3/xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t5+htzw9HBxMGNQ/hnIzdmW1YtgMPCpsOHc+n5b7KMkNAVwBHQ1Hd3+UPg5wk+U7J2P5m0Ou+lT7clF7KppekswRNfxAyMIoRtDNqnF+c+jS01bxfXBCJWZvQ2Nr0y490EGudtg7vd90+bUzXxNlOQIDUzbFwvC4XA9dSpOKMQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEFA3tw7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43ede096d73so9740285e9.2;
        Thu, 15 May 2025 13:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747340016; x=1747944816; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuJGtF+v5v/zwiKXtg5bHQxWdc3nNCiHNpzHfrfyNeg=;
        b=hEFA3tw7MqVpu7fUp+xjszCQtL9+6bIFDqo/BslicjrFPnG/1RXnhsOlf3iLSCQS2D
         RscDTDmYfdWGEsTUkkKd014GfVL3eJ3wyoJjkNPSG/hJ3pPQZyWyPfMyv4m5u3vPy4S5
         zTyRf/MzoX30K1bWq2/b8t8ZffssGC6dT5TGt5QsV6/NEXwrgFCZU3pumuYL4EXbNuZz
         0fDqU42/sYTdZoKD/s8/FdI4NAEaKiYcxqIafTPbwyV5384CXtAbSdQIxeTkvOLa7sJb
         j+2a2MTvrZBJMue86uGcuTpNUPBfLBA4et6k9MKeVK1PLfjD16bOSGPPXq/uKMx3KUur
         jNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747340016; x=1747944816;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuJGtF+v5v/zwiKXtg5bHQxWdc3nNCiHNpzHfrfyNeg=;
        b=uzSzAa61qYAoqrprj8UHolUjupoKkrMIKZIPpBr8r0wP+jTcaIxfuImJtR74qDY6t3
         oD0pYoBsInOhDjSg1BlebJoZppC3jpHf0uOZQdX9e6sLMyjQHpWWc3+lx4LadErCuv90
         jmpvi/hlddkrY7tAcQAVZ44KiUXwoeZkgFyKU6+CZfrGfYCGxr8bQoU7lOKFMD/yIKX2
         4ux22PCbgPC17w3TSJqkNx/CyxJY5HPXfV502y4oBTtwHOte7qPfbvB1NBC1GAym//ql
         zURN2e0hPrdUmr4DR5dytnCx5gshWa2eNGNn5Aj/gSiOHy9MsfEBIJUoPvMTAoSgvXG7
         7vKw==
X-Forwarded-Encrypted: i=1; AJvYcCUbth23XlgIbXhqTOb8knKq2CHYwhQPKuIvAuWC2V/z8iHP99vW7u5+Gdbn2CeCy+SYckZqyjoPkq3+zlls@vger.kernel.org, AJvYcCWRgEJndhzwZ2tN+v1Z6PpBB2tzvmntzNn55uYC9ZMATD7bMHgglYGR1ooqpr2xaD3v3lX+ZgHTRN1e@vger.kernel.org, AJvYcCWX8l1qY8AEVG9fAdK7T79vBkhez5YvF7NMzTgUzUIDiHsiMTvLucqYfEV23qO5rNgzlvSOhGV6j+KgGUu8@vger.kernel.org
X-Gm-Message-State: AOJu0Yys/3E4UNWwkG4ULDn/1809iyS67Smkh6xgHJfRS8H03+etH4kB
	UqXFp7C5lUuwnWplyMCSd27bI66sBuX2CjBM+ABbyb+yrgF7yH7jjRmBz18A+w==
X-Gm-Gg: ASbGncs4Csnfzk6p4JIehcdJehasU/vj9LGEt9R7R3HKbAas4WNgg5YtkzgXgbfuiEP
	O3DQGQyun3sUKE3gSoC5ATz2HJlnGOjsfjOKaSvMmZxoNRR0xQE/xqsAp6WfAYinRMvAZ7Ck56A
	vbMwtyzWbFu47sv4YVZ0KeD4bTO2P1k1lvM3wKTl9JyqC7BiI1Gv3nSoB5lAaf/gWOqRtaZvLN5
	qxbkf895ByddW8I+ESgQ2lA8rWe1Gg/oGyehcJbYXSbmsPd+wHEdYDIFCQQUnWbHggEwF+z/S2h
	3WxpHqrSo9JtFc6/bcw1d9zZWJaUp9l7uu0K2pOuSZQ9K0H++QdbjbAOG4Fw4eD+5JDDq5Ir4v0
	cswQS
X-Google-Smtp-Source: AGHT+IHG6RNWwbRDay3N+hyQJzL+sBLOAagvHNHCy6oSlBzCgno6ceuyCOZJAL6IFJsmeYnHqoVwUA==
X-Received: by 2002:a05:600c:a378:b0:43c:f70a:2af0 with SMTP id 5b1f17b1804b1-442fd64dfb3mr10603535e9.16.1747340015618;
        Thu, 15 May 2025 13:13:35 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442f3369293sm83248585e9.6.2025.05.15.13.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 13:13:35 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 15 May 2025 22:13:29 +0200
Subject: [PATCH] spi: spi-qpic-snand: return early on error from
 qcom_spi_io_op()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-qpic-snand-early-error-v1-1-681c87611213@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOhKJmgC/x3MQQ5AMBBA0avIrE2ipYKriEXVYBIppomQxt01l
 m/xf4RAwhSgyyIIXRx49wkqz8Ct1i+EPCWDLrQpjDJ4HuwweOsnJCvbgySyCzZ16apR6drMLaT
 4EJr5/sf98L4fECVEOWgAAAA=
X-Change-ID: 20250515-qpic-snand-early-error-863c4b1265f9
To: Mark Brown <broonie@kernel.org>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

When submitting of the descriptors fails, it is quite likely that
the register read buffer contains no valid data. Even if the data
is valid the function returns with an error code anyway.

Change the code to return early if qcom_submit_descs() fails to
avoid superfluously copying possibly invalid data.

Also change the return statement at the end of the function to use
zero value to indicate success obviusly.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 7207bbb57802ce53dfab4d9689113e7f9ba8f131..02b7e21479e5d5f663cd054b9241e6deb284b8ef 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -1405,8 +1405,10 @@ static int qcom_spi_io_op(struct qcom_nand_controller *snandc, const struct spi_
 	}
 
 	ret = qcom_submit_descs(snandc);
-	if (ret)
+	if (ret) {
 		dev_err(snandc->dev, "failure in submitting descriptor for:%d\n", opcode);
+		return ret;
+	}
 
 	if (copy) {
 		qcom_nandc_dev_to_mem(snandc, true);
@@ -1420,7 +1422,7 @@ static int qcom_spi_io_op(struct qcom_nand_controller *snandc, const struct spi_
 		memcpy(op->data.buf.in, &val, snandc->buf_count);
 	}
 
-	return ret;
+	return 0;
 }
 
 static bool qcom_spi_is_page_op(const struct spi_mem_op *op)

---
base-commit: 4614fd6342ab69feebb067d5db84a9bfb9aada9f
change-id: 20250515-qpic-snand-early-error-863c4b1265f9

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


