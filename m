Return-Path: <linux-spi+bounces-10913-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A247AC20140
	for <lists+linux-spi@lfdr.de>; Thu, 30 Oct 2025 13:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621453B8BD8
	for <lists+linux-spi@lfdr.de>; Thu, 30 Oct 2025 12:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775022D73B0;
	Thu, 30 Oct 2025 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HKl7agbJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="heLW9pFu"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7291D5CD1
	for <linux-spi@vger.kernel.org>; Thu, 30 Oct 2025 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828483; cv=none; b=AJSic1ZwI/E7Gb09JxSaswhk7xpl6ic24/xGk8BJ+ubIpkItiFO1T5TQgHh8LQoy+wSLmP+VV96BSln9CzQGBVI97UNZ8OoJZubVfCkO0gry8enD/rHYCF/f5Pg/UD962gUoSOszy9BHyNSRAUU6KePf6SLWoobhbjmHY2Fk9y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828483; c=relaxed/simple;
	bh=KOV6nt558CzNaBIDVg03/RcWMJwL/QDMHKjAkreK+8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q0YM3NfC39p+HUG+rs8YuOsxI8jSKvPY51bMKuxzedkJbKA4/BH7+W2/sFXgHJq0D+OuMFsYJU3xLv1BpkHisqRp/8n/CJKmLaeEJrDwj0QW+46pmUAgDK65vymHA2nv82rvlFjb3Y3l2WsN4wmqLqq5PSq7z6nCMzEMFuQ1gDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HKl7agbJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=heLW9pFu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U9N1Uh3116645
	for <linux-spi@vger.kernel.org>; Thu, 30 Oct 2025 12:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=G+IU4YveKf5LqulcS/K0IX7jygnBSHY3LH6
	3KY/K2BM=; b=HKl7agbJD6YDerN9a9TrrRDzFYGIP6rFoVIaIGxfEuFT73XZKZD
	Vnhb1rDNczNOhjHZozM0WgaChkM3UEqLhtSTUC9SIYSv/WPpd3jpM21ORxLSXpnd
	xb/Dv4koxT8BfeYdHcBaMjldhFS15Z6o7EFP7yIflUSVpaeA9iNg4moXwY5bmgwA
	hWd+sWWnJHv+im8sk3At2vNCbdOomTRI3toL59yFQt/K7oRuC56T4LNwfLBhNMJS
	UrK1CL4vN4lgKoO0urrCZpvD8udegY/0CHztuED2ZgsO7GLk/5H13/dahF9wOLAW
	K2YIMVso02WNTuRkec2AGRE+Smwy+qRY/8g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45b40jc0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 30 Oct 2025 12:48:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-336b646768eso1144076a91.1
        for <linux-spi@vger.kernel.org>; Thu, 30 Oct 2025 05:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761828480; x=1762433280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G+IU4YveKf5LqulcS/K0IX7jygnBSHY3LH63KY/K2BM=;
        b=heLW9pFuq3J4nBDSvf6xAo6Onf79uHrVxyE/sZbG9vWWQF3ga0IqhdZojUIWgz7KZ/
         ebKwNqIWZHBxlorImpcm+zqOIhYRHxZSVLEgfEfRQXllHQhpgox67pkY/P8l6N/mRyVB
         fdE84aoexqAN6p0AmKFafw7xCnME3SJPK5Gtph9wrTiO4rcnBUhqQarWG9obc0L+E/LD
         GpTkCAtY2IS89gIWz3r/UwD75DFQwKb74i3zjtaZKALzsOqQKevbLQc4SB7rzYnBkZIo
         WMEHsyV2k4/YZtWM13eWs1r4+neNcCkOZxt1D6WvwmyN7h8Am+w0BsQ219/Had/rMKb+
         5C6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761828480; x=1762433280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+IU4YveKf5LqulcS/K0IX7jygnBSHY3LH63KY/K2BM=;
        b=e6MMGwltSY3s3f5BTQ1CIXKF6HBG71nBQH5EsrQtRthYDRb8EJSiPv6W+GoLhsdqQf
         YHBdAeNHg3qdQ1rpIymQavoG7/snkT/zZrofLKc6kuPxiXaBfb/7vuBN9oyTy+XLd23y
         EyxNs+bXyeIqlijrJ3am0qktjo20uWMZep/VopcFlLg671Sa2FH2kwnb7Qr+TsgCB3Mq
         5bnG7kJXhjaftN5M0DTNcDCZCkyWq0Xl9RGCkq3CI1EwaVj7XJhFJoe3KIYIen+Q6Skf
         1u4A/GnWjD9thbRVsh7o2ZKSqP47gaXwlfXVaVoHkD4SxkAOkKsWtisxtkTBrBW+iOi2
         ftVQ==
X-Gm-Message-State: AOJu0YwavPnO+jY1LqtFPfGMALNtZWXIyASxf+HITOlsNYWAVA8Yp463
	2AHc2ygmRsai+KmpKkJ+xSEsQwHT0m3saRdbGNom14HPbObiVKCQYvVy76FGLpT9FCI125bHaJn
	VQ531uqEZIntiRCJy17SRC1FO1Do36JYPo+XoZq7eTTBVPNA/sLNSuz+nK6nqfkA=
X-Gm-Gg: ASbGnctc4qtxqcx+GlcNPVX225nyi8ojumjLHjPfPsTCKh2ofeEdrKUVMsDkfOiq5Zd
	1HENYr63pWry27ErNiQDncDo9E/wmvdRlT0C7HsmymybJBi9WBNDqITPSlF7J2NIz6N/R9hvL6R
	aciW6joGPh5vE0ZGEmmSmW4PuNTigx9FR0BXWgNKgJ9/7NhFsqrm18ZXI3PpMPPIVwsUAfexPVz
	bUUBWtu+wTdbSGGagJmPKHsuiRUlX4+TAUdIanRLAeokR/wofZXoYqal8kZlpCQhpSBzII+4JjB
	M25rBN/tWpz75QKITFz+dcz52Cd1WECE1UI8MqouKPHHrs91KDBcSfseDxmej1236zWAUscDhdD
	UxQkeSVZlN2Nt5phWqYNA8y7QiuuSBhS/vXgUq1ZVosN7X6GqSosbZgFLfkPRAQPung==
X-Received: by 2002:a17:90b:3bc7:b0:33b:d36f:a20d with SMTP id 98e67ed59e1d1-3403a303640mr8204848a91.37.1761828479688;
        Thu, 30 Oct 2025 05:47:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDpF2hpNsvy3jo/p/F4BKHpGq/32sA/EDX9vwxwOYby1CaPhDXXPX6GW3UIRk6vGiHO26Jvw==
X-Received: by 2002:a17:90b:3bc7:b0:33b:d36f:a20d with SMTP id 98e67ed59e1d1-3403a303640mr8204815a91.37.1761828479202;
        Thu, 30 Oct 2025 05:47:59 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340509e9f2fsm2555028a91.20.2025.10.30.05.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:47:58 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
Subject: [PATCH] spi: tle62x0: Add newline to sysfs attribute output
Date: Thu, 30 Oct 2025 20:47:55 +0800
Message-ID: <20251030124755.1828434-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEwMiBTYWx0ZWRfX9FvMslT9HkOE
 9kWCclKGTafRrxx0vf+HGsfHnJiQ3JaA0yTOEkorNHhn8Ga08qUqLTIAfYlxc0yd/6cW+tcg+gX
 KsYWI3QsNS+xLJA/2D11Ia+LkixpNQ+jkLTGLAyhwTF9/6ZxYOhWcGq3P81LVLTP+qDJrV0Ig0N
 lCu6QRWuWXTdJP6Cou+KYaA6Nm4U4JAAUJPSwX/N4FA+flVC+5eqjV7bB4aUoryvjRxkLINpiYK
 Nee9cDMDM6nxYMC1GyTFood9kpwS9n5Sm8x2UbnLBOqFbnp4xPSg2un22jU12tuvoW5QROoH6Jd
 37W3BytNAzDF/08PxaVdBl4z1XYjAy251na1r9sDLQf7ww9k8rddI/ynZp1gyrSqNLD6rawmOaK
 G+d1pr9lpChhVeUjPvE4/HY+ywkD2Q==
X-Authority-Analysis: v=2.4 cv=KePfcAYD c=1 sm=1 tr=0 ts=69035e80 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=GurJJKL-EhHNLGmuHs8A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: G9h9jEX-DZaiNmQy7IwxXcZTWmvR60sE
X-Proofpoint-GUID: G9h9jEX-DZaiNmQy7IwxXcZTWmvR60sE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300102

Append a newline to the sysfs_emit() output in tle62x0_gpio_show. This
aligns with common kernel conventions and improves readability for
userspace tools that expect newline-terminated values.

Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 drivers/spi/spi-tle62x0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tle62x0.c b/drivers/spi/spi-tle62x0.c
index a565352f6381..663c0136d119 100644
--- a/drivers/spi/spi-tle62x0.c
+++ b/drivers/spi/spi-tle62x0.c
@@ -141,7 +141,7 @@ static ssize_t tle62x0_gpio_show(struct device *dev,
 	value = (st->gpio_state >> gpio_num) & 1;
 	mutex_unlock(&st->lock);
 
-	return sysfs_emit(buf, "%d", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t tle62x0_gpio_store(struct device *dev,
-- 
2.43.0


