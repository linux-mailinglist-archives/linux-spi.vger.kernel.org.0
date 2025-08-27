Return-Path: <linux-spi+bounces-9677-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 635E0B381BE
	for <lists+linux-spi@lfdr.de>; Wed, 27 Aug 2025 13:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDC43664CE
	for <lists+linux-spi@lfdr.de>; Wed, 27 Aug 2025 11:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD9222A7F9;
	Wed, 27 Aug 2025 11:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="mSGgwRJr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086381EDA09;
	Wed, 27 Aug 2025 11:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756295633; cv=none; b=L0eUzmLz5uWNhKhlD4DZum6N42KntGs91lidvwFAf2hXfHNHX88c4gWMt562FRDCHNkGIAULRMjdy9TRMI0kO5RKo28od8rxd6lhPPnUIy2mk9UTuA2hli3gvcUNxwmZXuZQn4YryIAK0LBUAET5x4LTvhgdD1YN3uLxRb0t/7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756295633; c=relaxed/simple;
	bh=SIz/p4NfPnr2ZrJqsLLW8okce2AH2DfoK9BWXcRjiiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jRK1HKrf1xgQoos7XzLTX0BzKudCZsUR9vLa07TNyXfJibQdXbYt2AZ4geEt/I6y6lHKTLQ2eWP/V6QK4AocX4VslC2gkArHPngvph700+5LxWEKJoWkyjE0aEWffN0dvEQIpMq0R73OntMythA9e0cKBhQHHCgWg+RprbpkyNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=mSGgwRJr; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1756295629; x=1756900429; i=wahrenst@gmx.net;
	bh=o5/MQ81vBxshWRJWjvebrs9Qg8drXkBGoOx1ojmWO+4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mSGgwRJrFjagGuxN1EBS+mt7qb7u3XU3nBrJ8OFZMIzzYOUIRvIsmdVJh56mc2tb
	 bNwb22eX/LiL35mOgkrayEMJc2fQCjCZxic2tNDF2TJOJjW2H5hPIlMpBtoxbcMxb
	 rxhUSMFKu90U49dwzAM9LmG5Wq/RBReWqxSb2FoqzspvMki16FcasBgtEnI0mKQIM
	 w6ihWElbgWnnVDbOaNPkDlFpgk2M9icoxZAdfSYCnMwdkZ4QMMQH9d6+azYx36CTC
	 xgbZwnmOXU0P4zWVd8LopxjEbhC6XLIFsRcy4wxjLVORND/X3p2pGeOp8XY3pFkUY
	 qSLZOkO2etmPQx03ZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([79.235.128.112]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0NU-1u6sM90BUu-00hbzr; Wed, 27
 Aug 2025 13:53:49 +0200
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
Subject: [PATCH V2 0/3 net] microchip: lan865x: Fix probing issues
Date: Wed, 27 Aug 2025 13:53:38 +0200
Message-Id: <20250827115341.34608-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N+V8j1Fq6xtawRHCIFN/nwDih/j2scWxQpgS+GSibk1Y7OEwK4/
 wVTTFSoX/YNZRTFXf2hgRVYpAfmEPYUi0vVXb5n5jEZvaRlnKPfplRDZ22BdIuWfGxXZr2B
 01awgdu5dd4xXAK+s3GbA4iDE+XK1zOsLsV89J6255SmZYAHVxj/cquWyz23TsDsxBapw6z
 hp7WRUokg99bKWMQ5YR4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FzEWULW4Q34=;1+1kcY2HcuKqn2hX4zPFPIkQA3+
 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

Recently I setup a customer i.MX93 board which contains a LAN8651 chip.
During this process I discovered some probing related issues.

Changes in V2:
- Add Andrew's RB tags
- Also add lan8651 compatible to Patch 3 as suggested by Andrew Lunn
- CCs for stable

Stefan Wahren (3):
  net: ethernet: oa_tc6: Handle failure of spi_setup
  microchip: lan865x: Fix module autoloading
  microchip: lan865x: Fix LAN8651 autoloading

 drivers/net/ethernet/microchip/lan865x/lan865x.c | 7 +++++--
 drivers/net/ethernet/oa_tc6.c                    | 3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

=2D-=20
2.34.1


