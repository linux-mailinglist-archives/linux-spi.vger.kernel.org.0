Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D0F6A5AF9
	for <lists+linux-spi@lfdr.de>; Tue, 28 Feb 2023 15:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjB1OnP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Feb 2023 09:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1OnP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Feb 2023 09:43:15 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ACD1025A
        for <linux-spi@vger.kernel.org>; Tue, 28 Feb 2023 06:43:11 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:87f0:788:3682:ec7a])
        by michel.telenet-ops.be with bizsmtp
        id Sej92900Q5KNCAn06ej9Ay; Tue, 28 Feb 2023 15:43:10 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pX1Bg-00AORc-Ry;
        Tue, 28 Feb 2023 15:43:09 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pX1C9-00H9WG-Bi;
        Tue, 28 Feb 2023 15:43:09 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>, David Jander <david@protonic.nl>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: Replace spi_pcpu_stats_totalize() macro by a C function
Date:   Tue, 28 Feb 2023 15:43:08 +0100
Message-Id: <cb7690d9d04c06eec23dbb98fbb5444082125cff.1677594432.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

spi_pcpu_stats_totalize() is a rather large macro, and is instantiated
28 times, causing a large amount of duplication in the amount of
generated code.

Reduce the duplication by replacing spi_pcpu_stats_totalize() by a real
C function, and absorb all other common code from
spi_statistics_##name##_show().  As (a) the old "field" parameter was
the name of a structure member, which cannot be passed to a function,
and (b) passing a pointer to the member is also not an option, due to
the loop over all possible CPUs, the "field" parameter is replaced by an
"offset" parameter, pointing to a location within the structure.

This reduces kernel size by ca. 4 KiB (on arm32 and arm64).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Should the address calculation use RELOC_HIDE()? I.e.

    field = RELOC_HIDE((void *)pcpu_stats, offset);
---
 drivers/spi/spi.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6d41cef7f9c93934..56d078bac4236a09 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -117,24 +117,28 @@ static struct spi_statistics __percpu *spi_alloc_pcpu_stats(struct device *dev)
 	return pcpu_stats;
 }
 
-#define spi_pcpu_stats_totalize(ret, in, field)				\
-do {									\
-	int i;								\
-	ret = 0;							\
-	for_each_possible_cpu(i) {					\
-		const struct spi_statistics *pcpu_stats;		\
-		u64 inc;						\
-		unsigned int start;					\
-		pcpu_stats = per_cpu_ptr(in, i);			\
-		do {							\
-			start = u64_stats_fetch_begin(		\
-					&pcpu_stats->syncp);		\
-			inc = u64_stats_read(&pcpu_stats->field);	\
-		} while (u64_stats_fetch_retry(			\
-					&pcpu_stats->syncp, start));	\
-		ret += inc;						\
-	}								\
-} while (0)
+static ssize_t spi_emit_pcpu_stats(struct spi_statistics __percpu *stat,
+				   char *buf, size_t offset)
+{
+	u64 val = 0;
+	int i;
+
+	for_each_possible_cpu(i) {
+		const struct spi_statistics *pcpu_stats;
+		u64_stats_t *field;
+		unsigned int start;
+		u64 inc;
+
+		pcpu_stats = per_cpu_ptr(stat, i);
+		field = (void *)pcpu_stats + offset;
+		do {
+			start = u64_stats_fetch_begin(&pcpu_stats->syncp);
+			inc = u64_stats_read(field);
+		} while (u64_stats_fetch_retry(&pcpu_stats->syncp, start));
+		val += inc;
+	}
+	return sysfs_emit(buf, "%llu\n", val);
+}
 
 #define SPI_STATISTICS_ATTRS(field, file)				\
 static ssize_t spi_controller_##field##_show(struct device *dev,	\
@@ -165,11 +169,8 @@ static struct device_attribute dev_attr_spi_device_##field = {		\
 static ssize_t spi_statistics_##name##_show(struct spi_statistics __percpu *stat, \
 					    char *buf)			\
 {									\
-	ssize_t len;							\
-	u64 val;							\
-	spi_pcpu_stats_totalize(val, stat, field);			\
-	len = sysfs_emit(buf, "%llu\n", val);				\
-	return len;							\
+	return spi_emit_pcpu_stats(stat, buf,				\
+			offsetof(struct spi_statistics, field));	\
 }									\
 SPI_STATISTICS_ATTRS(name, file)
 
-- 
2.34.1

