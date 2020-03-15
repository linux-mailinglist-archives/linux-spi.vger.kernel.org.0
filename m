Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 484A3185E9A
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 18:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgCORI4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 13:08:56 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:36474 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728915AbgCORI4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 15 Mar 2020 13:08:56 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48gQrP5N7Mzw;
        Sun, 15 Mar 2020 18:08:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1584292133; bh=CFU5FJmuQdF3qv0nzTWEIX3XxtGpmXCO2Bcuo6/RtV0=;
        h=Date:From:Subject:To:Cc:From;
        b=PiXqnaA20AS+ZPf2FLuiICoBqDqhTadyz5LqerFkVUBgSqRIBBYTJXR8ArbG2AKoO
         /724trCrD+7cm39uQY61t9m6b7oY/diuhGUpEY8RX0P/2FBLp7iojPPAhkI85CemyW
         wiitnfK5PM1b5bfNhafcU9Bw7NKsuTvidPDsNakaqOyj8euJsuXNhDRJ5m5AgaBoA4
         Pp/C9hMiloWng4T5Bm4NeSyVU0xvRB84YapoYHRXsa537fl9PdnB5BB9kJlV62QCxj
         UP8Bdqg332NU3ZtC9+ig4R8Z/u7PiD7enNuH6TSU5GP16liM4jFpf1HsNS3MdTP2jW
         CF9oVWEyRBVjg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 15 Mar 2020 18:08:53 +0100
Message-Id: <45912ba25c34a63b8098f471c3c8ebf8857a4716.1584292056.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] spi: fix cs_change for last transfer
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Generic spi_transfer_one_message() implementation introduced in
commit b158935f70b9 has a bug in cs_change handling: it keeps CS
asserted when cs_change is set. Fix it.

Cc: stable@vger.kernel.org
Fixes: b158935f70b9 ("spi: Provide common spi_message processing loop")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8994545367a2..5012eabde468 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1206,7 +1206,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 				    struct spi_message *msg)
 {
 	struct spi_transfer *xfer;
-	bool keep_cs = false;
+	bool keep_cs = true;
 	int ret = 0;
 	struct spi_statistics *statm = &ctlr->statistics;
 	struct spi_statistics *stats = &msg->spi->statistics;
@@ -1268,7 +1268,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 		if (xfer->cs_change) {
 			if (list_is_last(&xfer->transfer_list,
 					 &msg->transfers)) {
-				keep_cs = true;
+				keep_cs = false;
 			} else {
 				spi_set_cs(msg->spi, false);
 				_spi_transfer_cs_change_delay(msg, xfer);
-- 
2.20.1

