Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B379B24C3EF
	for <lists+linux-spi@lfdr.de>; Thu, 20 Aug 2020 19:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgHTRC7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Aug 2020 13:02:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730068AbgHTRCs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Aug 2020 13:02:48 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07KH1UCK134262;
        Thu, 20 Aug 2020 13:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=j/oDWsRv895s55NF1YbL3HUUtH7qtXG3XNnJHAmUmGY=;
 b=kKuVEVlmxtyvZBTknwfXOOXvRe4Eu7uYqolxWWqfOH6aVDrnPQ0UYQNUabtkyIGC5qsa
 fbbm1/N/eX30sFh0xlPjGsIYIgL6ItsPgTWmI5o75kz90YyWlDNkWaKC/I7MJQv9gnqM
 bjYRA3O+NeblkCdc30JIGmw81rA4hb+ZKaIH0uSPTIzK9i/GqqvQ05pLWuRLPE7z+FN4
 I4BufddVO/G2U0luQC7skXkyBuoBXo5V4PMfD5EOAzQ0bWq1MF+3RMWNfvke7CKrVVOl
 twvK0N6OQbvu4k4e70gnymwjceoAA673ijqJT1ia6BPMURzSEQkKF22d5wPwAPKLzjKy fA== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 331ugy3fdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 13:02:42 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07KH0guK015112;
        Thu, 20 Aug 2020 17:02:38 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04wdc.us.ibm.com with ESMTP id 3304uewqq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 17:02:38 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07KH2coK43188680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Aug 2020 17:02:38 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14170AE05C;
        Thu, 20 Aug 2020 17:02:38 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29DADAE060;
        Thu, 20 Aug 2020 17:02:37 +0000 (GMT)
Received: from SHADE6A.ibmuc.com (unknown [9.163.70.74])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 Aug 2020 17:02:37 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, joel@jms.id.au, bradleyb@fuzziesquirrel.com,
        broonie@kernel.org, robh+dt@kernel.org, arnd@arndb.de
Subject: [PATCH 7/7] eeprom: at25: Split reads into chunks and cap write size
Date:   Thu, 20 Aug 2020 12:02:28 -0500
Message-Id: <20200820170228.42053-8-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820170228.42053-1-eajames@linux.ibm.com>
References: <20200820170228.42053-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-20_03:2020-08-19,2020-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 impostorscore=0 suspectscore=1 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008200135
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Brad Bishop <bradleyb@fuzziesquirrel.com>

Make use of spi_max_transfer_size to avoid requesting transfers that are
too large for some spi controllers.

Signed-off-by: Brad Bishop <bradleyb@fuzziesquirrel.com>
Signed-off-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/misc/eeprom/at25.c | 94 ++++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 40 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index ed8d38b09925..30f0704ab2d4 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -64,12 +64,17 @@ static int at25_ee_read(void *priv, unsigned int offset,
 {
 	struct at25_data *at25 = priv;
 	char *buf = val;
+	size_t max_chunk = spi_max_transfer_size(at25->spi);
+	size_t num_msgs = DIV_ROUND_UP(count, max_chunk);
+	size_t			nr_bytes = 0;
 	u8			command[EE_MAXADDRLEN + 1];
 	u8			*cp;
 	ssize_t			status;
 	struct spi_transfer	t[2];
 	struct spi_message	m;
 	u8			instr;
+	unsigned int		msg_offset;
+	size_t			msg_count;
 
 	if (unlikely(offset >= at25->chip.byte_len))
 		return -EINVAL;
@@ -78,57 +83,64 @@ static int at25_ee_read(void *priv, unsigned int offset,
 	if (unlikely(!count))
 		return -EINVAL;
 
-	cp = command;
-
-	instr = AT25_READ;
-	if (at25->chip.flags & EE_INSTR_BIT3_IS_ADDR)
-		if (offset >= (1U << (at25->addrlen * 8)))
-			instr |= AT25_INSTR_BIT3;
-	*cp++ = instr;
-
-	/* 8/16/24-bit address is written MSB first */
-	switch (at25->addrlen) {
-	default:	/* case 3 */
-		*cp++ = offset >> 16;
-		fallthrough;
-	case 2:
-		*cp++ = offset >> 8;
-		fallthrough;
-	case 1:
-	case 0:	/* can't happen: for better codegen */
-		*cp++ = offset >> 0;
-	}
+	msg_offset = (unsigned int)offset;
+	msg_count = min(count, max_chunk);
+	while (num_msgs) {
+		cp = command;
+
+		instr = AT25_READ;
+		if (at25->chip.flags & EE_INSTR_BIT3_IS_ADDR)
+			if (msg_offset >= (1U << (at25->addrlen * 8)))
+				instr |= AT25_INSTR_BIT3;
+		*cp++ = instr;
+
+		/* 8/16/24-bit address is written MSB first */
+		switch (at25->addrlen) {
+		default:	/* case 3 */
+			*cp++ = msg_offset >> 16;
+			fallthrough;
+		case 2:
+			*cp++ = msg_offset >> 8;
+			fallthrough;
+		case 1:
+		case 0:	/* can't happen: for better codegen */
+			*cp++ = msg_offset >> 0;
+		}
 
-	spi_message_init(&m);
-	memset(t, 0, sizeof(t));
+		spi_message_init(&m);
+		memset(t, 0, sizeof(t));
 
-	t[0].tx_buf = command;
-	t[0].len = at25->addrlen + 1;
-	spi_message_add_tail(&t[0], &m);
+		t[0].tx_buf = command;
+		t[0].len = at25->addrlen + 1;
+		spi_message_add_tail(&t[0], &m);
 
-	t[1].rx_buf = buf;
-	t[1].len = count;
-	spi_message_add_tail(&t[1], &m);
+		t[1].rx_buf = buf + nr_bytes;
+		t[1].len = msg_count;
+		spi_message_add_tail(&t[1], &m);
 
-	mutex_lock(&at25->lock);
+		mutex_lock(&at25->lock);
 
-	/* Read it all at once.
-	 *
-	 * REVISIT that's potentially a problem with large chips, if
-	 * other devices on the bus need to be accessed regularly or
-	 * this chip is clocked very slowly
-	 */
-	status = spi_sync(at25->spi, &m);
-	dev_dbg(&at25->spi->dev, "read %zu bytes at %d --> %zd\n",
-		count, offset, status);
+		status = spi_sync(at25->spi, &m);
 
-	mutex_unlock(&at25->lock);
-	return status;
+		mutex_unlock(&at25->lock);
+
+		if (status)
+			return status;
+
+		--num_msgs;
+		msg_offset += msg_count;
+		nr_bytes += msg_count;
+	}
+
+	dev_dbg(&at25->spi->dev, "read %zu bytes at %d\n",
+		count, offset);
+	return 0;
 }
 
 static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 {
 	struct at25_data *at25 = priv;
+	size_t maxsz = spi_max_transfer_size(at25->spi);
 	const char *buf = val;
 	int			status = 0;
 	unsigned		buf_size;
@@ -191,6 +203,8 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 		segment = buf_size - (offset % buf_size);
 		if (segment > count)
 			segment = count;
+		if (segment > maxsz)
+			segment = maxsz;
 		memcpy(cp, buf, segment);
 		status = spi_write(at25->spi, bounce,
 				segment + at25->addrlen + 1);
-- 
2.26.2

