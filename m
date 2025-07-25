Return-Path: <linux-spi+bounces-9189-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67254B122DB
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jul 2025 19:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C246AA251A
	for <lists+linux-spi@lfdr.de>; Fri, 25 Jul 2025 17:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA3124503C;
	Fri, 25 Jul 2025 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLDbJAuH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3AE7405A;
	Fri, 25 Jul 2025 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463858; cv=none; b=TqM4tSH8bjGjhJRvQaRO6giZCQjZ4haD4xBa/xa2Mmc80AjFUmpHspI8I0yRXG5BJfvzxbapn0vQjbsLBay5sG6qAz9MlcmqlTEQjowbkZbCueWXAAOtgL4j2dZouY+BXimuG0MadeVQNUKq/H2B00Kr5zkqFfe1DoLEDG8uLgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463858; c=relaxed/simple;
	bh=H8oVB7tbJfJPzjUKlhGLcntO2j81AS9BOfoI5XpVUjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oWoMhYfPeclg4SDW5sN5wfqOKzuldqmL0cX/vA2F3xh0NOFWpE18qtS6zDjQISX6OFIQhrUVPhiC/8fy6Rtodhv1nYWhhYAwBMNyeMNNwx7knWn0DhDDIuIKMwXR0b/3sbKR5BgrTsmNeW6oKkYzEG3tMvrd+wkQ5bdU4rrKq4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLDbJAuH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4563bc166a5so15104865e9.1;
        Fri, 25 Jul 2025 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753463855; x=1754068655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VYEfVFgUuHHAe4nANqQt6FiSWoxhhUOMDeuUi1wRFwk=;
        b=WLDbJAuHgMiz4ymyhfH6Exkscy7rgH1rLn2PS7F47e/9I6vzJ3hrAS1Z1477lY6MyO
         JKGXsTwO9GHc95P55iMYFIyiBKQPl1Efh90kh7x9U1OnEHp24VZv8WenrVbgtRT/JrKp
         9FwZhPyRmfnRtvfWABxhpmiYm5YBj7MQlC43p8gCYVTs6r0zXVGCEYtFhmVtXA+HvmiE
         Q2k0oR/RrU2f8jc/Ka/JMUoy4n8kQJj+5lXY4Pa2JOdrO7Xgc+PdygKqtv/6w5uRg8AG
         7QBP93jpFjUQJ+AB2aOZYzyrsW7u6Qi1TdFe9NK1WfaEzXmvZbf/mGHEgb46TcVRfq/8
         feCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753463855; x=1754068655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYEfVFgUuHHAe4nANqQt6FiSWoxhhUOMDeuUi1wRFwk=;
        b=bHvMZbpLqrvIuN4QVPwQtNNuLMICEYEMH71B68iNohcMy5YHASm0U4ApGvTT1JveIX
         X1thGPbGWFdEW+YUbqfS/JsuqrXYDFx49Ju6yGTGFAhkMDkc5T7ad6dpvkvMP8ATpmnn
         HykfJ0kNWesEC8vx1Lsq6QngJ78zHFgYKclThP93zoISu+0TMnxaA6uwP79eIVK+Qfhx
         iwVWGPm5/AAsJdohkTQ9Zc8hW4VgNlTgX0xtar91yUTvcJpo0W1JKUI0u7ABtk86M4Kt
         QUsoJHCpd3U/2FcZwK1tlfG/JqXutIo2XhfDsf34vGPjMxLLrHWnky2vPHaQ2EwfsncT
         dBLw==
X-Forwarded-Encrypted: i=1; AJvYcCUByVRjotsNoPYH1ytT50ae7XozfV0bfx5/X+R8x6pToJbXZiJ3lKbFBi6HXU8On/mQZyeL/ZgrhTZv@vger.kernel.org, AJvYcCUrFb7mapsPUB+C6RyrTP1jWZ7G2k7qFj3T2KLgEtGbpWiu/ptBxPmx0KmEV1LKj6qqW7yGw2+QsP9/fCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq3sK8q6hKx9oso47/f3qhBszsMUiiFzSR+QssMWNHMkXc49ri
	NIHwEKk18O0P41ji83kax8FOjbFb4T9ZQaFV9yrsorMwZmdeqTeU65TgyDa+ggft
X-Gm-Gg: ASbGncs78QcL9T1Exh+Z7a2S7eV0GU58T41QiGifjI0gMaZ3SqPC5RsObSeWKqt5pEe
	cHxQQFrJtbR7WqSIOcpNwwo1NSXN0uLxLTx0OjMKlvHjjkRWclJVRt1PkMVDC7dNsMyxEtJbg3D
	+y03sypPId/JMTg95K+zmc+jqWsYBdLDo76eh5meohvQpSZ4vDZRBCW5aGMWd2AWDVbQE1tMnhd
	s53e28y6N8UvcizioH+FFeeLk3Je9btw2rqVePRR2v+W0pN6OkW5V/KqECDqtFfryuJUSXThgHR
	BM7E+lJLoClbVMNpgiBTASbVJZCdxx+/+N7CmPaXVvsgmYgPtiGauYwhcsJIaExv+/kqx1AMIUR
	+2L8N8WypjPvNQC90qZ2L
X-Google-Smtp-Source: AGHT+IFb4M2x/WyWLKn9ceSAsdqfGQJveOFeSQN3mN6Pu9YA6R/D8wn9Bi/6mXDLoSYpOQ3z73ioiQ==
X-Received: by 2002:a05:600c:12d4:b0:456:23e7:2568 with SMTP id 5b1f17b1804b1-45870580784mr44472685e9.13.1753463855174;
        Fri, 25 Jul 2025 10:17:35 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b778f104ffsm393174f8f.66.2025.07.25.10.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 10:17:34 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Mark Brown <broonie@kernel.org>,
	linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] spi: SPISG: Fix less than zero comparison on a u32 variable
Date: Fri, 25 Jul 2025 18:17:01 +0100
Message-ID: <20250725171701.839927-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The check for ns < 0 is always false because variable ns is a u32 which
is not a signed type. Fix this by making ns a s32 type.

Fixes: cef9991e04ae ("spi: Add Amlogic SPISG driver")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/spi/spi-amlogic-spisg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amlogic-spisg.c b/drivers/spi/spi-amlogic-spisg.c
index 48a5325b4db7..2ab8bdf2a676 100644
--- a/drivers/spi/spi-amlogic-spisg.c
+++ b/drivers/spi/spi-amlogic-spisg.c
@@ -163,7 +163,7 @@ struct spisg_device {
 
 static int spi_delay_to_sclk(u32 slck_speed_hz, struct spi_delay *delay)
 {
-	u32 ns;
+	s32 ns;
 
 	if (!delay)
 		return 0;
-- 
2.50.0


