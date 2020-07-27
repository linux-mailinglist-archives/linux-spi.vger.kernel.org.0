Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD15222EB6B
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 13:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgG0Lra (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jul 2020 07:47:30 -0400
Received: from mailout10.rmx.de ([94.199.88.75]:60922 "EHLO mailout10.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbgG0Lra (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Jul 2020 07:47:30 -0400
X-Greylist: delayed 2076 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jul 2020 07:47:28 EDT
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout10.rmx.de (Postfix) with ESMTPS id 4BFcbk088pz31wH;
        Mon, 27 Jul 2020 13:12:50 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4BFcbK2FfZz2TSDj;
        Mon, 27 Jul 2020 13:12:29 +0200 (CEST)
Received: from N95HX1G2.wgnetz.xx (192.168.54.121) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 27 Jul
 2020 13:12:29 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Christian Eggers <ceggers@arri.de>
Subject: [PATCH] eeprom: at25: allow page sizes greater than 16 bit
Date:   Mon, 27 Jul 2020 13:12:18 +0200
Message-ID: <20200727111218.26926-1-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.121]
X-RMX-ID: 20200727-131229-4BFcbK2FfZz2TSDj-0@kdin02
X-RMX-SOURCE: 217.111.95.66
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Storage technologies like FRAM have no "write pages", the whole chip can
be written within one SPI transfer. For these chips, the page size can
be set equal to the device size. Currently available devices are already
bigger than 64 kiB.

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 drivers/misc/eeprom/at25.c | 2 +-
 include/linux/spi/eeprom.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index cde9a2fc1325..0e7c8dc01195 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -261,7 +261,7 @@ static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip)
 
 	if (device_property_read_u32(dev, "pagesize", &val) == 0 ||
 	    device_property_read_u32(dev, "at25,page-size", &val) == 0) {
-		chip->page_size = (u16)val;
+		chip->page_size = val;
 	} else {
 		dev_err(dev, "Error: missing \"pagesize\" property\n");
 		return -ENODEV;
diff --git a/include/linux/spi/eeprom.h b/include/linux/spi/eeprom.h
index aceccf9c71fb..1cca3dd5a748 100644
--- a/include/linux/spi/eeprom.h
+++ b/include/linux/spi/eeprom.h
@@ -14,7 +14,7 @@
 struct spi_eeprom {
 	u32		byte_len;
 	char		name[10];
-	u16		page_size;		/* for writes */
+	u32		page_size;		/* for writes */
 	u16		flags;
 #define	EE_ADDR1	0x0001			/*  8 bit addrs */
 #define	EE_ADDR2	0x0002			/* 16 bit addrs */
-- 
Christian Eggers
Embedded software developer

Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler

