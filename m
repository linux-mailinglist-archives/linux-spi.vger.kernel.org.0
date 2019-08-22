Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE53D9A21F
	for <lists+linux-spi@lfdr.de>; Thu, 22 Aug 2019 23:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393369AbfHVVZA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Aug 2019 17:25:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36639 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732609AbfHVVZA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Aug 2019 17:25:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so7128882wme.1;
        Thu, 22 Aug 2019 14:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2wGo/YiSTpvz565aGzvgcGHwqI5KdtM5ozK5uEe+N3Y=;
        b=iVX3BDMDjmfIMXh8OHrZZ7TxSTuvuFoMI91e+NfQ6KUH++d4e/rnepDjb+r31kLBbo
         phuXCSM7lV+bACavBKAS8TnO3ELkdqXwPzoL3NlkgAXqdNhy2xqbJ4s4A5whN1sfktOp
         4jpuInf1iF2dVJkLqbxAvrJraFo1GpBr12PLdHfqBYhgdr8JqGgKJbiWBKGEOVxs34Rc
         cXYXkBs0lFjnNRezTPpVHlKBPPOnW+KDfPBDZGoFU7xKq8+n6xXy5olBnmeH9aGshKX1
         9h2wGdrV17QCafI3KP0Lynun4PuESiKiQe+yAIqPcLHGvEGZO5dO9CXom3pl/fhYBCff
         B/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2wGo/YiSTpvz565aGzvgcGHwqI5KdtM5ozK5uEe+N3Y=;
        b=Zz5zV/icR8kyi9ixrsqfDsDP8YAV6+K6vcKSqZUNiYqPErnFnJxAjP23tE2+O1ci0U
         bypTb0o5oFUbnJ8CazDeAJyQ6byBYFaS/7Ros1DAyf8tc1BvQcRGv7VmLUZyUnpVE6Lk
         f/riKBuQ+JS2w4deV0AWJRYyQptn0YiC2qTHoAS9q9EkORt3gtA+1stIzFUoDBBOBvtl
         7qpJhXQDE4t3XnB32PVmiyNlA84TflXMZxp1Qe4CYyCDnBFpgwxtrqSsppInzUJTRTNq
         t5Vt7YgutOJsXWJ/0FLAOqtr03vWdJFpTWtEDXieVbPzT/XqJopmn3cF9Vpv3FSNgLCU
         /5Xw==
X-Gm-Message-State: APjAAAXWzC0TvbJ75FcnR5JBpj9c0IRFo7ULT2KjcaHWAuPtLs1SX4qV
        cugdcVtMdbwhrp5Z966uCQ0=
X-Google-Smtp-Source: APXvYqxueUWCUlYoVPBGUkE2tTXhggnOdrMAbzDqVQRDyWliszgA22N14x9MoOYEdy9fFO2yfzQ1TQ==
X-Received: by 2002:a7b:cd06:: with SMTP id f6mr1171095wmj.66.1566509098187;
        Thu, 22 Aug 2019 14:24:58 -0700 (PDT)
Received: from localhost.localdomain ([86.126.25.232])
        by smtp.gmail.com with ESMTPSA id 7sm463135wmj.46.2019.08.22.14.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 14:24:57 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH 0/1] Fix shared IRQ behavior in spi-fsl-dspi
Date:   Fri, 23 Aug 2019 00:24:49 +0300
Message-Id: <20190822212450.21420-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch is taken out of the "Poll mode for NXP DSPI driver" series
and respun against the "for-4.20" branch.
$(git describe --tags 13aed2392741) shows:
v4.20-rc1-18-g13aed2392741

Vladimir Oltean (1):
  spi: spi-fsl-dspi: Exit the ISR with IRQ_NONE when it's not ours

 drivers/spi/spi-fsl-dspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.17.1

