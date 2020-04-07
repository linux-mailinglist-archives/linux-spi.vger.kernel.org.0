Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64AF41A0E02
	for <lists+linux-spi@lfdr.de>; Tue,  7 Apr 2020 14:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgDGM4H (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Apr 2020 08:56:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35182 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbgDGM4H (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Apr 2020 08:56:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id a13so783677pfa.2;
        Tue, 07 Apr 2020 05:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ig7enmh1xqIMupAhnVZ5RcpKxVtZ4Uzul6UlsPcv9Oo=;
        b=FIBzdmVYE5/QR8uThRRfspwHjQHAjgZbz5ao/Wp76m2VqcEenVSVXZoC/Yo6XFDdy9
         vf1QNp8sEL4A8RcUHzLkz97KM6x5MCTfdRf3QKFYXRs8aXEGwGFcrdqE8t4sut3leebc
         h13UrxbngqOquAGLFAG7dFoWQpglYEZPFYA2w0EfUBUhVJR3AVy84W8EJ8/DRL7kBLPe
         sWj1V0W2j58Tm2DiL/rmeTdM3y7/HGsy8copHBJdHun6RUJea8HHz47swXvHnq6sCC+p
         fqj85f5md2lMKLseDGMccylPsfZXnafjMJSwzWjuZJxpvnUJuQe826HJa//x/yCdWvb8
         C6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ig7enmh1xqIMupAhnVZ5RcpKxVtZ4Uzul6UlsPcv9Oo=;
        b=nhypyazG9KnU4DV/N1kZ10ut3IMX75AN0do69z+MHXMhQQlK8AWt5PI4Ik0i3ytney
         UFntt+BSQG9V5ZFOFPbLWX9XGvn3KjYgw+VY6TkDuKGwvETBFkFPx9hJQrRh2zLH5Qf2
         VaMKxKfHmQyCbY0qMiou3NSX23/Ml86TKUW4ENWa1+jpAk3l/m+u12+vMCE2ag5d8EKl
         zqhgb6TCLTDwrThJe4WYF62YdM3YAu2xeU6OOD+MndIHasBIHrHkDLy16ORKvS/P5Ry/
         swj7rHW7GN3n3nilILXg1moYysXNdbiNa/yVBePVB9usncTRRo4OS+eGXzrdBCba+uWf
         HuZA==
X-Gm-Message-State: AGi0PubxHRmxSZ2lWIHBbHKq+sYJuFIJYjvFQmAm/Fx+gRPlpVqA6/6m
        kySZxj7EHzhOsWV9xye8W1A=
X-Google-Smtp-Source: APiQypJCX0vTZj1qAlLIiM04lysN4jvTPdTdU+Qyz3k2eJZ/+bCQ7tQ+2inYApfUkA63pzMDXVV6RQ==
X-Received: by 2002:a62:1a90:: with SMTP id a138mr2565217pfa.320.1586264166323;
        Tue, 07 Apr 2020 05:56:06 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:600d:c36b:d50:b01b:c4e4:35ad])
        by smtp.gmail.com with ESMTPSA id c62sm13746195pfc.136.2020.04.07.05.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 05:56:05 -0700 (PDT)
From:   Aishwarya R <aishwaryarj100@gmail.com>
Cc:     aishwaryarj100@gmail.com, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spi-fsl-lpspi: Fix indentation and open brace should be on the previous line
Date:   Tue,  7 Apr 2020 18:25:57 +0530
Message-Id: <20200407125557.6520-1-aishwaryarj100@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Resolved open brace { should be on the previous line checkpatch
error and fix the indentation

Signed-off-by: Aishwarya R <aishwaryarj100@gmail.com>
---
 drivers/spi/spi-fsl-lpspi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 8b41b70f6f5c..511211b82430 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -186,14 +186,13 @@ static bool fsl_lpspi_can_dma(struct spi_controller *controller,

 	bytes_per_word = fsl_lpspi_bytes_per_word(transfer->bits_per_word);

-	switch (bytes_per_word)
-	{
-		case 1:
-		case 2:
-		case 4:
-			break;
-		default:
-			return false;
+	switch (bytes_per_word) {
+	case 1:
+	case 2:
+	case 4:
+		break;
+	default:
+		return false;
 	}

 	return true;
--
2.17.1
