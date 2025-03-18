Return-Path: <linux-spi+bounces-7189-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05266A66D89
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 09:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022801891A9F
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 08:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044DB1E5211;
	Tue, 18 Mar 2025 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z781ALgI"
X-Original-To: linux-spi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6AC1F2C52
	for <linux-spi@vger.kernel.org>; Tue, 18 Mar 2025 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285363; cv=none; b=DPtbMaPDmr6RV0cBcpx2Zegrn7LLr30wzizN3jEs0Q7oTsASZBUYMNcdWNhau+p53a7mNt17YrXJIjlIl3hBS5I9tHPFiJ6ETYryHPMqhLoOTX5kxFfWage2bkaruAe+rD006jXvPVeONgQkhs4x+8jozx2IY4Uv6EvAIbjnku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285363; c=relaxed/simple;
	bh=7Mp3l5IFx+cBU0LtsyIxw8lHW6ZgPBAyf3KkmP0Weno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=LD7Bg9l+224pA1+3gureOyq8NCkFHIjRSXBqidyN8URPUbbKtDw5B9OfgN/ARSnuGIbYl+3KUevHPNgJJ1aHM57pXH3DBcZI+4spbmD/FHUaaARFKk1yk4rnZfXVpKMYXsN0OWmADpMVALhYxmyHtCGG8DSdEzPRLD+L6SdPIlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z781ALgI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742285360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1MOPIMVq4RYa2Qlhwo2paVsAS+Ja31+A7+LmeILgDQA=;
	b=Z781ALgIB1y5AXfOr0JXbTeWqDF9zTFlviD1Jun0bA2yMXbZNJ4n0OqrC5qI6hisUjVg8L
	TvLbhIV14hVLxgHOxVOOT/o3d/mrQnvqaPkfebv9BeG5YhVWxG2+0EUNlX6NyTt/RmTTtt
	Q4Pd+kx1FNJNMkIGrTgjNn6Uk1YCtH4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-QjoUKHFdMySnBsBSY08hzg-1; Tue, 18 Mar 2025 04:09:19 -0400
X-MC-Unique: QjoUKHFdMySnBsBSY08hzg-1
X-Mimecast-MFC-AGG-ID: QjoUKHFdMySnBsBSY08hzg_1742285358
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39134c762ebso2254756f8f.0
        for <linux-spi@vger.kernel.org>; Tue, 18 Mar 2025 01:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742285358; x=1742890158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1MOPIMVq4RYa2Qlhwo2paVsAS+Ja31+A7+LmeILgDQA=;
        b=KghfJHcTT9C7ePH0MGjofK0uCRvH7z95DSOvOuiHkAZvGBa+fi7SUxLt5jYIu5V22x
         utD8pKKa8ZqY1kyZLpODAboGI6sRPk7YEg5Ygx/sadsM7krMCjoc9o+B4N1fSaVIoV+9
         mwETIPeze/ieTcM+Oa1nqvS5ZW8V30qotYKs1oO8s3K+5wMTQ0BzwD3eRu2Mnnm9OtJn
         6nrdENKnm4QQbQB2tlJFZ+xeNaWjCbC4xEXKr+vxyPvSYu/pRsbuvkS1KGlzKR27x1bE
         8muIyZE0oehebIH3q9IQdOdYX2SoXSUTMrGRDIT+/br2BKOgcEFoZpL0f1xj0/gkrwB4
         pn2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVppuRWrJhQEmhaEjM3ktPsE5zEbC6kajmNQz4wjuiNN/Kq0bPAsvVSuHekPAjY9aMC4cWouVhRj7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwajfETGzM4CzJNkkkIqwQWkLFznCo1UmPt8g+PBeYo9kK3jgqX
	7ZovrFWgDaSL4K3jzjRKWPaM5UrhJZfF19zb2EaSqfqMalyP8B6l3G2srsQau87kbGi9/aiJoob
	ia1QbIXh6Q/lzrvuZS6iu5HAxXBoSXX3wZZfqNZqaO6hTtVgfP4KlarRkQg==
X-Gm-Gg: ASbGncsO4nEmcXP8o5wVNkTREN93j+Ebdxw/1G9KzbfDK5tSG7erY5nNSKFXiANCrY5
	TzPuxlLPulLMuaZ4KoCQ12VMsmw4DEBRet2adFcgRUR0dk71298E4v/WKvnbB1Nf0HyFRpkxc6y
	g1mIi19Cc07gNm2iGDOk8ell16zS1l6sC9X/da0X2lE+D/tdt8P8DjHMIQBmu0lkvIPdAS2Imjd
	NJ4KoIVA3qpd6r+Bhy8ddb+IT8Df5kcqdbUWDwnRrlg+KL8zu8qWyLkV+6UKUDJQOsiw+2G2Ewa
	WCgcQxCfkl5sJ4bi5nFoPSoshfvWbk3AwNuTQpiy1AFIuOyB4Wr6L0TNMjFiGVM=
X-Received: by 2002:a5d:64e2:0:b0:391:3d97:bd33 with SMTP id ffacd0b85a97d-3996b44670dmr2495608f8f.13.1742285357970;
        Tue, 18 Mar 2025 01:09:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTLxf1mjfmE9kJO903aRfrs3DFnwMwFBN6shttc0uogtpGRU10VKPtw6/ONRx4vNAinDz/MA==
X-Received: by 2002:a5d:64e2:0:b0:391:3d97:bd33 with SMTP id ffacd0b85a97d-3996b44670dmr2495582f8f.13.1742285357554;
        Tue, 18 Mar 2025 01:09:17 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318a75sm17490878f8f.76.2025.03.18.01.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 01:09:16 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Maud Spierings <maudspierings@gocontroll.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust the file entry in GOCONTROLL MODULINE MODULE SLOT
Date: Tue, 18 Mar 2025 09:09:13 +0100
Message-ID: <20250318080913.31455-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6oR8u1RAskHArvL-W0_qgK-m51lyeYWNVomnTIhe-qo_1742285358
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 8f1cc5242544 ("MAINTAINERS: add maintainer for the GOcontroll
Moduline module slot") adds a new MAINTAINERS section referring to the
non-existent file:
  Documentation/connector/gocontroll,moduline-module-slot.yaml

It intends to refer to the file with the same name in
Documentation/devicetree/bindings/connector/. Adjust the file reference to
the intended location.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 561d394cb210..92af00cd0eee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10022,7 +10022,7 @@ F:	drivers/media/usb/go7007/
 GOCONTROLL MODULINE MODULE SLOT
 M:	Maud Spierings <maudspierings@gocontroll.com>
 S:	Maintained
-F:	Documentation/connector/gocontroll,moduline-module-slot.yaml
+F:	Documentation/devicetree/bindings/connector/gocontroll,moduline-module-slot.yaml
 
 GOODIX TOUCHSCREEN
 M:	Hans de Goede <hdegoede@redhat.com>
-- 
2.48.1


