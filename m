Return-Path: <linux-spi+bounces-8279-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8D4AC3517
	for <lists+linux-spi@lfdr.de>; Sun, 25 May 2025 16:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB581894F42
	for <lists+linux-spi@lfdr.de>; Sun, 25 May 2025 14:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835D4433A5;
	Sun, 25 May 2025 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXFEvqYJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF09111A8;
	Sun, 25 May 2025 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748182540; cv=none; b=Xd2Mb1vVilkXVWcAUDQvX09NIJMpPusF49yT08weKfQNsIiMpgQ/6RCI70a1Ynq+8B/CknlxCIkRDzRFhC4fYronmcC+7XVFNm3K0UQgtDmt2fFNYujtr8c8hqUHK8tWP3G5X7cPbWHAE9GLTxm9deVdUY1W/eL6/HbXj/QcWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748182540; c=relaxed/simple;
	bh=wmGk+TBaNRY5nDS1rKgBaAEKQmTkq/N72QkhaTSVfWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z6bw3nkzwP0WGQHDNWc51fM44TLZBKl2TxN4WZvMGMS1yy1r3pGmkq63YoV+FFjzLqyAzFwCRrBrOrGNn4Zuq1sMB9afzPt2JTPow92M6q83FfFJ1e5dKMoLlXxXCi1AdYdUq/OGW5V9hqvzUsl4HjAS2HBP1TMr83vlir0ER5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXFEvqYJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf257158fso12188975e9.2;
        Sun, 25 May 2025 07:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748182537; x=1748787337; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IZcVpD8BamrnSmEiURzydGig52hbzqfoQ0eu8lXwHW4=;
        b=SXFEvqYJpVDl44nMBmZMxxW5UfPMQVn2PeqSZnScTBbEO/VHdUbpTZoaS+L6kqSs2A
         OfSVoMxKc1oEb0bTpYihWtnDmrlDHEe9mWOPo3/1qDd7ihtLIrQQRlu4l/9qgltSIRrV
         IJX1TiLD7HpMMpD5+dLEnhlREgWhnauFadpPyXXErI2iNljISD4mm06LqZ1CPw9yZsgm
         5oFIDUlNyVhS1tde3gdNGgwytywjKd+r4AJNARFApPiJmYvu968u+FNwxb69MRT9LnVG
         rX69KjAdrPQUm+BA5GsADjwJ5qp8V+6vy3bLHMOw6Le7UH3wdQ8lcZwM5GPLjYjjorvb
         SAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748182537; x=1748787337;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZcVpD8BamrnSmEiURzydGig52hbzqfoQ0eu8lXwHW4=;
        b=NLc88FHKEOR2/Z8DgaiqeLO5z1oVz9sZcmP39JVVo8zEooXWLyl87ZKvUU4NLIWACE
         rQD4eNC1Zf20DT0FupuWPbyLwuW10GGCjhWq35JcdylZQ3fj2/XGivbe8VXbpnZR/6iV
         KlniJsOtk97Nc+pjbJF422XIwTEKnnl4Al+EtiqY6tHDNCxsUnNhVtybIb/v8uaUFCI6
         KJYpsyQyx/DxQVdR2oP3J79CprwXCaB8z8h01AQ9p5f7AA2H0DyMeTq7M/3m9heoNcNb
         E24MkmXLCV2q3Z1l3OIRgTMpEwMELAa8Lkr6wWateYkytRoSeYbS/Cyxj5Ad1Epy8Q4h
         qdUw==
X-Forwarded-Encrypted: i=1; AJvYcCU4hqgS2g/gZj46pWsVOltehy3OrImht1SJHc1NsQefeJ/hCTO+MyVtSbr6IuYFj0efiDaSCUBgPacTZUU9@vger.kernel.org, AJvYcCVlitl5+IcBrTeK4gxeZX16cvEqmJlW5I5CcrynsXob2K4GQkpceWX0ngTAzh+mrETCPwGR938lZ14jyicv@vger.kernel.org, AJvYcCW2CDkZqAJ4NE6/4shIR0ohoNbxVctmVSqSxlpAZ68YVUrItflyD0QvMQhFDhN48f7y+mXC4PiMKyQX@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+pkF+jTuTs+gU6/iskBUJS+CqqEZqZ1/iTw5ovpvkBwzUeY1J
	sxIHZHLp96MEKCPTlQraEE7kWGnhyKlQ3yTAg7N58CZxlRfXppDvlMtkcDMXXw==
X-Gm-Gg: ASbGnctR8rLLfY8mCzs1U7nfCkTBrmTGU7fpABqSeSNuH9fL1Uiu54Y0VPvWvJtKhrw
	SZwLYE2/54GpwZR0f7pTE3JtVO/IpI/OIDMV22VBeXWA0aMVz25qsPABVbUe2EVJ3VoTMFkvnJl
	lf+p8W2sCI1I0vhKOLjrF3Vb/zP3QACFXuAz2Upe+g9fuQfg3nFln70Iv60AQlJ6795C13at8Qx
	YXP8YmPaJzbEAIRnqyliDdQKS9xrjhwzfBpKmQHocE2P3HZL15NP7/f3xzLAaIG7hLRVxONTHhE
	0ooFVM3EwsUnikCtv6mNMDQZ5QHFqIGj0Z88QBYGlB7HTkGOdIpFn8WlYF20+I40EJ3Z9vc0l8a
	WTATouUgRLolqVZI=
X-Google-Smtp-Source: AGHT+IF1N9STeA39eRmGKM0ICfxskkUCsw4Lm8yXlQoDq9JXVNyUdGxuzaTax6DPjJd8skO1R3hUTA==
X-Received: by 2002:a05:600c:8487:b0:442:d9fb:d9f1 with SMTP id 5b1f17b1804b1-44c933ed9bbmr55049605e9.4.1748182536874;
        Sun, 25 May 2025 07:15:36 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-447f7bae847sm203607445e9.36.2025.05.25.07.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 07:15:36 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Sun, 25 May 2025 16:15:25 +0200
Subject: [PATCH] spi: spi-qpic-snand: use NANDC_STEP_SIZE consistently
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250525-qpic-snand-nandc_step_size-v1-1-6039e9bfe1c6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPwlM2gC/x3MQQqEMAxA0atI1hOoxbqYq4iU0EbNplMbkUHp3
 e3M5sPb/BuUi7DCu7uh8Ckqn9TQvzoIG6WVUWIzWGOdcdbhniWgJkoRfwleD85e5WJ0oxmXgYg
 jGWiDXHiR738+zbU+WbYWRWwAAAA=
X-Change-ID: 20250525-qpic-snand-nandc_step_size-5606f4aaeda0
To: Mark Brown <broonie@kernel.org>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

Change the qcom_spi_read_page_ecc() function to use NANDC_STEP_SIZE
instead of a magic number while calculating the data size to keep it
consistent with other functions like qcom_spi_program_{raw,ecc,oob}
and qcom_spi_read_cw_{raw,page_oob}.

No functional changes.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index fd129650434f0129e24d3bdac7e7c4d5542627e6..037178d6576e82c3f19c3cc2c6c78f056dc488af 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -821,7 +821,7 @@ static int qcom_spi_read_page_ecc(struct qcom_nand_controller *snandc,
 		int data_size, oob_size;
 
 		if (i == (num_cw - 1)) {
-			data_size = 512 - ((num_cw - 1) << 2);
+			data_size = NANDC_STEP_SIZE - ((num_cw - 1) << 2);
 			oob_size = (num_cw << 2) + ecc_cfg->ecc_bytes_hw +
 				    ecc_cfg->spare_bytes;
 		} else {

---
base-commit: b00d6864a4c948529dc6ddd2df76bf175bf27c63
change-id: 20250525-qpic-snand-nandc_step_size-5606f4aaeda0

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


