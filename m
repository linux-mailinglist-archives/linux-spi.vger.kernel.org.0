Return-Path: <linux-spi+bounces-10720-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351F1BEF6E4
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 08:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF933AAB63
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 06:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E942D5A0C;
	Mon, 20 Oct 2025 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="RcAlToUC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09802D29D6
	for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 06:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760940631; cv=none; b=lKzJKVPDx6sd4BCf9wQmh+GiTVyNSiUzO7NeX/B86Fc58Uf/8ToIQBmJ8Bx6SiI3xqXAy3q3s6QgzRR5GLH9N7zYuRT/xwc3mjdgLromYvTa2JZKoE8/lE0ZxBcyxS+iRT0+EDNgeKGD41HD7ct1e9Gp41Uu1wFGR6Uiw/MlXps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760940631; c=relaxed/simple;
	bh=N/kOmsWTL71eukFzwqT5DRUUrxZtrYJzllMFUs/neE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQBxTZawOrq2pt+DAQx+VcEinVae/5sRkxV1LnVqMIxGv35Yfjf/6U0NAe/DL3nkiV+gZzDXyfaWvAJ1XgrXTbRsZIX9Gq/ZnhBwVw4cH3zu32c+9qbJ1GUjHx7C35DueGcVvpbtQdUVMbCiD7xSVfhuIxnAVPbbLT/AuW4ivLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=RcAlToUC; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=v3wtCgrKpXpY06
	IA1iepJUf0jmIsp0liDp9ZApSd2Z8=; b=RcAlToUCuHt6nQyz8co6yRNGfUNVuA
	8UzaTOqAm+ZiKuYB6NvSL17xZZHja1eptPR9iXoEYQBGPdQC3sXqxoudg+VG9Gmv
	OxUSs4rwvpAAgGWj9GHbiy3mt5o3RLhYbpUAGKNgwuIxrnOf9s1PQVJFGAPWouwS
	B45m5DP9YiELKZ+xmtYQlTFsLRSEfyPp6EDndXCiaT5lRfuDe1cmcokUmxi1OUQK
	KRBi4E6z51+bIw8ljzVmThRm8I7SANs4R3Pymh4pKIU88x+vIlSE29oX8FH3V4vP
	3UB8yZtXWU+4F5Dt5qQ7k1mIgouCg4AvmpmdWAXvteCVTfOmyVNzKRew==
Received: (qmail 940898 invoked from network); 20 Oct 2025 08:10:25 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Oct 2025 08:10:25 +0200
X-UD-Smtp-Session: l3s3148p1@9Ldn8JBB9LkgAwDNf0fPAEuMhp6AgTGK
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: devicetree@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	imx@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	Liu Ying <victor.liu@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 0/4] dt-bindings: treewide: don't check node names
Date: Mon, 20 Oct 2025 08:09:49 +0200
Message-ID: <20251020060951.30776-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Node names are already and properly checked by the core schema. No need
to do it again.

These are all occurrences I found in linux-next as of 20251015. I did
run dt_bindings_check successfully. I haven't done a way to run
dtbs_check yet because I would need to identify the proper architecture
first, right? Is there some tool which tests all DTs of a certain
binding? At least build bot is happy, I don't know if it checks DTs as
well, though.

I'd suggest to give subsystems some time to pick these patches before
Rob applies the remaining ones?


Wolfram Sang (4):
  dt-bindings: bus: don't check node names
  dt-bindings: nvmem: don't check node names
  ASoC: dt-bindings: don't check node names
  dt-bindings: spi: don't check node names

 .../devicetree/bindings/bus/allwinner,sun8i-a23-rsb.yaml        | 2 +-
 .../devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml | 2 +-
 Documentation/devicetree/bindings/bus/st,stm32-etzpc.yaml       | 2 +-
 Documentation/devicetree/bindings/bus/st,stm32mp25-rifsc.yaml   | 2 +-
 Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml     | 2 +-
 Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml       | 2 +-
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml      | 2 +-
 Documentation/devicetree/bindings/spi/spi-controller.yaml       | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.47.2


