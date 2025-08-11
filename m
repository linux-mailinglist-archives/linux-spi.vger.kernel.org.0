Return-Path: <linux-spi+bounces-9344-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E116B21102
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 18:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80956880B8
	for <lists+linux-spi@lfdr.de>; Mon, 11 Aug 2025 16:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C0A311C1D;
	Mon, 11 Aug 2025 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="SVesFYn8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1BC311C06;
	Mon, 11 Aug 2025 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927360; cv=none; b=u3/+DP/hiosuNGAECRPUl10E9t4ZC3/XfLVOlZSOpnrxkNhlCtGS5bE5PDqU/l77IFZ8K9XqqmIvaQUFmTYMqE0f2xwof1CpKgki8uNlk6nMgEZLHJXZ7iDYSDSlVbpSteH5nM1ZwQR5LuUbXPhnsMmWuatiLnQr3+wlnMI614M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927360; c=relaxed/simple;
	bh=b2kYo1EDxEkl6j6tNEeusmiKPGIkRrLEur5k1wnnDjM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DbhJL+4Cp4mzgsv6w6lMWE2gdcedQSlt4GNXZQ+4Bhkc2MR0Kb6DNib6joc7ABNg2cZwvLusSeGXX9GjtklUk8nKk3fCaKDkl28prEXzGrVDGyQYDpJFRIt3+mSHq7jP2IqdpmZmp7B9kUD/dGLIlk3zRIS5/zHEfB8cCbkZhbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=SVesFYn8; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1754927356; x=1755532156; i=wahrenst@gmx.net;
	bh=TliC346bEtsVznkVc/bVtsemg2ANcD0k0xZ+VVsQ/aU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SVesFYn8qih7gU0JIM3NZqYNglXwjCYY0fU/u4OQVi3ZPU/IyyNnP/T+Pi7+iKS9
	 UsVikuDmTN2F8qKuG+Y7kasdaEQ9j6Af9Ypjngw+p9OeZ91hofWps2rZ5eGxZHedz
	 eKL6AM0AK/I+f85rO2PIAQG9A80+HishlVGCOC7fx9eRypcIPtQHj51gVDf6A7Ip2
	 wG822gWhWLdZCX3nGuuKnFGwoQtb1C7bEujrxs1oOl0f5Mjg+nxnd8EuejXDrnaHF
	 fBv2dCnVsiOM17Ruu7nvSZufB5kOFK6+zusXxikp+D+Z3K8cWcQfL/p564XXO5QUk
	 JeS66UNd+wbeKW+u9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([79.235.128.112]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGvG-1v5wcU1mFa-00JUQY; Mon, 11
 Aug 2025 17:49:16 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-spi@vger.kernel.org,
	netdev@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 0/3 net] microchip: lan865x: Fix probing issues
Date: Mon, 11 Aug 2025 17:48:55 +0200
Message-Id: <20250811154858.8207-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6XIRmJveBcDwKnHVlI4WQyEczMflwLRvRD66rR47RHF097972vi
 pbGmlgtMD57lUpqeMnqINVBovt+TDsRhHhUMYtf+MYHl2x3En7fQckNb0AuXJEgvns+jFHt
 jxfg0GmAD8qbzfjNrAAax+AkwAA+/aDPhpoJJu6TpN/b0f+9T7HUKiIidui9Kx05z11vCRa
 h4OwluKJcQdt89AKCBr/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lW54q/8zH4o=;o+OmXN5IxnGUBnqkPzioLC3KBNF
 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

Recently I setup a customer i.MX93 board which contains a LAN8651 chip.
During this process I discovered some probing related issues.

Stefan Wahren (3):
  net: ethernet: oa_tc6: Handle failure of spi_setup
  microchip: lan865x: fix module autoloading
  microchip: lan865x: Fix LAN8651 autoloading

 drivers/net/ethernet/microchip/lan865x/lan865x.c | 6 ++++--
 drivers/net/ethernet/oa_tc6.c                    | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

=2D-=20
2.34.1


