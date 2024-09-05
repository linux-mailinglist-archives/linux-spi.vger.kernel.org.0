Return-Path: <linux-spi+bounces-4654-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6D796CF58
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 08:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28DD1C221A9
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 06:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DB51714A8;
	Thu,  5 Sep 2024 06:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="KNgcjeQM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1201C1FA4;
	Thu,  5 Sep 2024 06:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518094; cv=none; b=h1MHYJ1eXYvI+E9Na+Ngh7w6L+PImHf6F+TfgW6qPuhi3ttFg3L4aijyyZfNAci0oQV9H4/3u6ajdb9FaAK7us8Bpa6lVOaQn2Bao1dYlJ/pE89g0x9XWzAU39O82voMfRfLVWp1Jetwanh3Fzc/u9LuRFsARK+9yPkVA1/5skw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518094; c=relaxed/simple;
	bh=vuW78umX7eRwKQ7H3ca+ZiCwMUFkCmDuU/2+kVSuuyg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=hOVlEDsIibSkpCcLtW2C3NWsu2pu8n4GBGjcenz0yjWi51Dep1Lv/NgR/tiYO5bmVMSlp+Xexv03hbZRFnwYrD6DMUiTvJv3A3oLWqnzBhNlLh7D7Zpn1GbGElL0IWE6uUaoyWHHNoL2CSMi/Rx7mUO2t5f+kU1+PdH1HgF6UqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=KNgcjeQM; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1725518083; x=1726122883; i=wahrenst@gmx.net;
	bh=vuW78umX7eRwKQ7H3ca+ZiCwMUFkCmDuU/2+kVSuuyg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KNgcjeQMyuDamQYFa7hJa830qO/y0XzU49RVOQktW+aGMaot7e7EuG7PR6TUBWtw
	 lBTXEU6qmgzyUHIRFY55Kti3WTIwIDhkvzim7Cc/gKuQemYYsCzFXUkuiqZQwzppe
	 TjA7nywttIGCSI74dTd6HvPvWL9MrsAGesb9X7Zy5CerRxRplR134kCive3ZYJ5eq
	 RXcsolGXOc4M/Au+vVkDMZPUaeATY9Th0Q2JkYBlM2zb0/tkcHNsQ16bwP5QGy/CX
	 zDiOKQDsEB4uC2MJTQwB7sNy6CdQhMx06YH8v/sbeySZARpmQtubA3Xliq5rc66Gw
	 d5mnysAeg5+9000ASQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mn2WF-1sNFem01Zf-00bxOj; Thu, 05
 Sep 2024 08:34:43 +0200
Message-ID: <1112988f-7c53-42df-94d1-7c479ea276fa@gmx.net>
Date: Thu, 5 Sep 2024 08:34:42 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Carlos Song <carlos.song@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, "imx@lists.linux.dev" <imx@lists.linux.dev>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
From: Stefan Wahren <wahrenst@gmx.net>
Subject: Maintainer for spi-fsl-lpspi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K88aRC+k9ZVmcNr9i4OFf3okBPW/VrOsm9AMOjAaoiYMGCiuC6v
 i72pYQh9Igzy5kviHTPTTl+tJvbbVhNbJWXmwli6nM7FLcKtOhjYlFCQ++e1FAEknw7LMR+
 GGh+UjvzzXyfwSo5xxo8/nsaxt02jZ/LIMpqXu5fR5QQ8HS/HJP1Cwev4L8e1h0gYNutUzh
 /LndjDF+AS4O87hRmzVwQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jqRxZcFkjDU=;rAuEj18lGs7vLgHU5Cts2HLV6OU
 9LKknYqKmIFG8Hh2//MxKGcvacP84DBBWYr5LbzJ+y4L9LEgaEsuLRjnzYBP3ULfoim0Wa8oK
 i1TSQrGSwMrUarp1vx9wbzctq8PRKSU1CieCui0E71QgEADy0WaDjH+5wUiWZUdVrKW94FyQI
 vA/ND67nUqatxBvP1LkBHlX4o7xZl6CeJAtwjaGbZCAyqe7VW1Trj5cpENcokO2wBYQvb77Oz
 K31yXKgipckMkpbXp402DGtu8KA9LjJuXwq5wGHdu02kmYoBut/5qtbhHVlkSYC1qKcbBJo1i
 CMHFCeaoBRSHqoxIxoQ7s4D0JvRdyZJyKa+6V0Wwp25CA5IWx8bBb8063ISP4yEZH8AfRMCam
 myyn+9eI2yxQq7lcUC1GiDv6rNGLoWHqQxZuZjOOXQyTe9uUIpEZ6pFQSoFTGhCpeiriBdiQY
 LM/dcFmGusfgyzmQflqBodXT2ft9xWGdzuQHXG9gSOlxaoZxEV9g092qx0tIGOcPkpQy/+aEL
 ycyj6HNSxDDu4FW55/3TzaSO6iyYaL0A+LeFGAU0jmzzGf61UGd2QPDGSs3ld5hB35BdeFewQ
 UrKFAjF2I8jJ+5vlDdE74T6bU118N4113fT2GK0uMBsod6VcP3rTlAOdSp0HsgcGDNuZfgYMO
 18tidOK1jhuUJvA06E4VvgyfauhNUeTjAF0/2kkepbXxca7dSybXL/MRxyNwBBjeRz+6LllXm
 5L/sOo7fPNfjkhM/z4V4pi0LVQnIfMRMxhQvSBCBQqvmI27yaNi6WKwoJ7c+/TqdkeVkgUl8g
 9d/IiLp9xzGTSt1UcXc7TRlA==

Hi,

i noticed that scripts/get_maintainer.pl for changes on spi-fsl-lpspi
just provide addresses for the SPI subsystem. But my expectation would
also be linux-arm-kernel@lists.infradead.org / imx@lists.linux.dev in
order to give the platform people a chance for review.

Is there a plan from the NXP people to step up as maintainer or should
it be added to the IMX architecture?

Best regards

