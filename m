Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC6316AB59
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2020 17:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgBXQ1t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Feb 2020 11:27:49 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43235 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgBXQ1t (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Feb 2020 11:27:49 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so10768681ljm.10
        for <linux-spi@vger.kernel.org>; Mon, 24 Feb 2020 08:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ch8jDv4d2lVUss9JtmCpT7kCDVDRcrySJz7oaLN6G1s=;
        b=b8lmom/rAMtHH/w/LzIBqA+wRdSCDC9mkJ5R8AIx8bBGDMsgxkyLWSDpFLHBRvI9J3
         haVVFktne1yjnVEGJTAyDjPOMlCIt+51khWhR8vB5560Pq/JHu9bzZBRgz7HX/VLhALW
         hcS/94wXhEiHPcEkIsDt0Sn7RL9S7eDTQgCgEyo8CNzC36PY3TzkKdWWUN6nauEDVO6o
         Ttp0ek+jCfPjf0Hk1yEBJGD346eewSY+F/vFGlvnJ+V56z/0vgXwofNHYwlGkIs0agVj
         bnNN4gWtrV3jZTVwoTbJPNFF0MhQI3TqxLQhjVszzCGlQwteAkIRNib0LsJmYPScxRyV
         Ra9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ch8jDv4d2lVUss9JtmCpT7kCDVDRcrySJz7oaLN6G1s=;
        b=ELrZ7P9xWzAX8LpQ9yOySRcV+sNiUHSw8EKSOefSC6hYTL0AT1sncQvBVJtdX0hTLf
         abwRb6pDowDZJRQEKiMMt1W9j8wfUWZGb6hmcxHewz4PYF1Qu5uQNwnjVF4q7ksqmNEy
         D1dOFcrYHpXj047mWgjjAPW+t/dQjmvlXKEBBSUQmJLb6PKdlBO8Z9A0Evfeq0Hp2QDW
         24y4opE/f1NGu6qe8vPd6gwX01y03+ykZY7illB7d/PiWpkKnmusy3Cndfc2+zio6gkQ
         8aUvvWfP0XEumFkJC+9CDnxAovz+wl/5Ds+w3P0xBoyO7dfsJBgOyExqS0zVjRjcjRLM
         Chqg==
X-Gm-Message-State: APjAAAU62Kdn8exjkKtGblDPOydJrL2QiwHuAxk54/i+842FMpju6IXY
        TY2p2PdsT1/xJDY6XKqF6xQ=
X-Google-Smtp-Source: APXvYqyPNctHcX1rG/4sEpkCPeTYU2k57BozeagQWPPCb0DYFCNA1lSdZqGoHUqoEo9eUxe27TvRDA==
X-Received: by 2002:a2e:98c6:: with SMTP id s6mr31206548ljj.14.1582561667019;
        Mon, 24 Feb 2020 08:27:47 -0800 (PST)
Received: from natalie.tramplemo.net (2.67.140.62.mobile.tre.se. [2.67.140.62])
        by smtp.googlemail.com with ESMTPSA id v10sm552946lfb.61.2020.02.24.08.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 08:27:46 -0800 (PST)
From:   Thommy Jakobsson <thommyj@gmail.com>
To:     broonie@kernel.org, michal.simek@xilinx.com,
        linux-spi@vger.kernel.org
Cc:     Thommy Jakobsson <thommyj@gmail.com>
Subject: [PATCH] spi/zynqmp: remove entry that causes a cs glitch
Date:   Mon, 24 Feb 2020 17:26:43 +0100
Message-Id: <20200224162643.29102-1-thommyj@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In the public interface for chipselect, there is always an entry
commented as "Dummy generic FIFO entry" pushed down to the fifo right
after the activate/deactivate command. The dummy entry is 0x0,
irregardless if the intention was to activate or deactive the cs. This
causes the cs line to glitch rather than beeing activated in the case
when there was an activate command.

This has been observed on oscilloscope, and have caused problems for at
least one specific flash device type connected to the qspi port. After
the change the glitch is gone and cs goes active when intended.

The reason why this worked before (except for the glitch) was because
when sending the actual data, the CS bits are once again set. Since
most flashes uses mode 0, there is always a half clk period anyway for
cs to clk active setup time. If someone would rely on timing from a
chip_select call to a transfer_one, it would fail though.

It is unknown why the dummy entry was there in the first place, git log
seems to be of no help in this case. The reference manual gives no
indication of the necessity of this. In fact the lower 8 bits are a
setup (or hold in case of deactivate) time expressed in cycles. So this
should not be needed to fulfill any setup/hold timings.

Signed-off-by: Thommy Jakobsson <thommyj@gmail.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 60c4de4e4485..7412a3042a8d 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -401,9 +401,6 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
 
 	zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, genfifoentry);
 
-	/* Dummy generic FIFO entry */
-	zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, 0x0);
-
 	/* Manually start the generic FIFO command */
 	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
 			zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
-- 
2.17.1

