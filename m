Return-Path: <linux-spi+bounces-4952-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9BF984B5A
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 20:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE481F2452B
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 18:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BA91AB6F3;
	Tue, 24 Sep 2024 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pBEI3FVI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1BF1B85F5;
	Tue, 24 Sep 2024 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727204203; cv=none; b=S6+AW7xSLhEpiXRcntGCCwl0EzpvVXH8vncHwb92j7K53ku5oBv6Hjo7aYhThoBEvk8467WbKigDdrbtL5NG6FB2NDurHIqRCkPU2R7mqCBAQScKgrE9I1Yr66sqNu8YCWPcNwW1SmhE4DASn0dO7NdJG0jQelTv/PoB+8v0aIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727204203; c=relaxed/simple;
	bh=IE/J+hvgo3ewlVUG0R49ywG4iE/URV1ZJt7ABD6Zxcw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=utqCiSG4AhKEN00/wAjiZyfNzuyxbcfkb+5BMqRUG7iohnaEj32oeIl8OK1L/yD+tduiDH5fWjW2FVkiPZ8qB7VC97cpbj00jBd/DqyefPOBXld7u7NqF+qQleCTWT/IqfU6X19BprPuTXnYsFDpcYiFNA/xmrQBLBgqbAdfzg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pBEI3FVI; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727204171; x=1727808971; i=markus.elfring@web.de;
	bh=xtgGbVbvQUG8PMEUJblOJ8LFdHNg6Vwo3Ynbfh+i3qM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pBEI3FVIc1IfThbHLTs5fZWx+EyfCYbnXCIwbI9TYt2HvYap1b+FDPajviduVN9+
	 6f7kgepm0b7olCGuxGYWuXRUc1hr4yGUhxKx8WwOiZl0W1qC/dGq48HJ56Nq56HF9
	 mZcM5CDCZnN6I4p7tFU74N6YWtkfJcRMJ1mnxUrJAhWmttFW7h18DDRN17CB/svi9
	 jRifesdsIwyvCzLPP0Rn8oGvjZqp4F5fx13CaxmlRUrkCky1tXpw2+tpUJSnfgpjt
	 mG4YfnwYWwNVzFH7XOCApgOAMJVEj4+DZYDnd/WxhuRdEBB2DsMPlhmlz5kRyvgnS
	 VSWxFLU7IEdOpLrBiQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMGuC-1scC3J0dRW-00Jte0; Tue, 24
 Sep 2024 20:56:11 +0200
Message-ID: <9e736d33-b07f-40a0-8fb6-8c3212593b77@web.de>
Date: Tue, 24 Sep 2024 20:56:08 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] spi: slave-mt27xx: Call clk_disable_unprepare() only once in
 mtk_spi_slave_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lAmuIvmJ2DJWOgYJ5Dc3Jikut72syDFBPNFRoqxnjuz6Ujva0lB
 qiZZ+p9Wuxrm2ek3g7UBLIulwG6eCJEvYXPPIPxqBDMqtEXbDY94QGDrxQn5c5fjQoxxiGw
 Lwp3TOi9wLEY3G+3wgwtUeguwD6xYEG2ZBC+UXUbdvG3Srwb83eC9k+/gP71gaZud1wtsX/
 Hret41lADO+dIUB9dihyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P16q0sytqk8=;H2wCb/e128pNNd7DaC2wcQLJfUD
 ldEzgMl/8BflG0oXh31sV/bNA9hFclbt87UQtMPh52YFdLDaBekekaGAXks9PhdDaxCl5Flpj
 j1m+zimbcWy0Psdy7bKiK1p7ijljub/bkBaE6TKwMnhvt88rSVex80oCiBuqzdGE7KxK+G5/E
 1sY201r6hljICeXuqGB+PuhWTxr7kX9+db+i275D7364JnV5iNUoDTFdshgCaSOake7rJNw6q
 Pd0S2JnVH/lk5BT5tCbJabKbOuBhIF5oOstzemrJQ6U1OPIkxStDzXCoIOr6dNz0KhnmKzXrn
 /cvWgeGg41nDFIv/PlpNsQXf7XphXgqNZbT1v1EMI+7IO74FbNFZmGae2/APxzVIxtMGlIEcd
 aFpL3lEqekkHpNVphjxjQnFYM2diBgb4vPxVkVQT2NvnM581eX4A9Szm/EtjXKh+9IjAwMMCN
 9ZHgtw2yT10XVILFSKdMnv9PoB0ESpp3qgaESI/Nlq0L8FcsYLuvYwOZ5d5m/d4qYY+sn8ZEh
 /qdobvZZ7sirsFSoGqCW4t95Tu7bot7r02j65mKQlcrM5LhdlEN+/pu4+//5oQRj2Gpkc4dwm
 0xnw+oRGhFh9/P9UKCoDv8CvzO/RPTkBo53dZOtRKqZ7vwevZ7nBPwjqpFUshTbbxDVrrWU4j
 HvQyUkG/IvjHNmPzj1EugMbJ3ZZglGk7omraGq9cWo+6IOV6t2aJzMC53s/UjkXO1+fv8fC1R
 fEMGxCu0dOHyGqcVpWZFYLqm68SAgkCwNlfxzEdMjpu2kmlpkfXFHcc06JY8V9mmYQIh4yoh6
 XQjnvY8mf2VL9iJiS0PgddWg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 24 Sep 2024 20:47:29 +0200

A clk_disable_unprepare(mdata->spi_clk) call was immediately used
after a return value check for a devm_spi_register_controller() call
in this function implementation.
Thus call such a function only once instead directly before the check.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/spi/spi-slave-mt27xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-slave-mt27xx.c b/drivers/spi/spi-slave-mt27xx=
.c
index 4a91b7bae3c6..40e1e7de0742 100644
=2D-- a/drivers/spi/spi-slave-mt27xx.c
+++ b/drivers/spi/spi-slave-mt27xx.c
@@ -455,15 +455,13 @@ static int mtk_spi_slave_probe(struct platform_devic=
e *pdev)
 	pm_runtime_enable(&pdev->dev);

 	ret =3D devm_spi_register_controller(&pdev->dev, ctlr);
+	clk_disable_unprepare(mdata->spi_clk);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"failed to register slave controller(%d)\n", ret);
-		clk_disable_unprepare(mdata->spi_clk);
 		goto err_disable_runtime_pm;
 	}

-	clk_disable_unprepare(mdata->spi_clk);
-
 	return 0;

 err_disable_runtime_pm:
=2D-
2.46.1


