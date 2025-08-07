Return-Path: <linux-spi+bounces-9312-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44C0B1D582
	for <lists+linux-spi@lfdr.de>; Thu,  7 Aug 2025 12:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D210A163309
	for <lists+linux-spi@lfdr.de>; Thu,  7 Aug 2025 10:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048A412E7F;
	Thu,  7 Aug 2025 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="c2olVYZ8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793A821CC61
	for <linux-spi@vger.kernel.org>; Thu,  7 Aug 2025 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754561269; cv=none; b=OqzeUHy+S7TyEsMiDt5/nF7UOTVOF5YNDm+iU8P5pzTAvSJSKorY1NiG0wC7Ma/dx+ImKZCTSbRAQFywAnfQGx5rNo2Rp37hdnY8oqW4/iHVkV1w18mIDAo4vbu/IPnxcPEVAGCUpuJRtbf/+P4ZYy3OLEbsyK5EZObv0Vi/pMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754561269; c=relaxed/simple;
	bh=ttH59wqrImyhHUkFmLmP74mNxfU/HlC0dMS+1VMvhdY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bsa8G/fwVY/HJLYGGYyIxwTO+RdDR86ky/QtjZ11Z1zwd01SwN3oqtrEq6Q01cGG0nvxHBFvyWTn5wP2o1GmcXL155OWQOqLPspb2UOjkB0Xgr36Hvu3tXXm5zX+rQpLNL82LWns8Ee/LW5rBu75oFC+7IZhfF/7OfOqypHM+rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=c2olVYZ8; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1754561265; x=1755166065; i=wahrenst@gmx.net;
	bh=RxWym3zzt2d/9rcYlsMwAmxOxMg4sFEbqrDvRtkZMkI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=c2olVYZ8vjMUDQca+dvwqbMOqaKO4r854YK1Gq98/367nRNppMobyxQ5e9YqsF/O
	 67sMLEmjd1fy+va4ISUijq9XuIzasZqRFejqx26z7O2m9fceP0ZB14AQGPCzKDJTx
	 G3llaESr8jQEx2O2v56aJFBgQ74JYMDWf5+XT582Ug/q3TY/bkoPQ5PCdq/xEjuEe
	 w6q/oUsEvMH9GVefpZEIFr8fVfDRibLMFOhK92YR8EGquS6pCb2SWpbVD+io6h3Ki
	 hgAfygo6c+Hd/97D26eQMRgCkAswPskwdiDE/Ex28HAKjdsjyHMhmyDVTINHAWuIl
	 Ya/Oj50NXeS6MRU1Xw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([79.235.128.112]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mgeo8-1u7ZqX1uqi-00nBnl; Thu, 07
 Aug 2025 12:07:45 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Frank Li <Frank.Li@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Clark Wang <xiaoning.wang@nxp.com>
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH] spi: spi-fsl-lpspi: Clamp too high speed_hz
Date: Thu,  7 Aug 2025 12:07:42 +0200
Message-Id: <20250807100742.9917-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z7HJ19V5RDNWe3wuUth2csYyED0MSNHqcGL6c9q6bNE97zmefzb
 pIDi2rnjgzpM7PbFJPu3W0vam1Z6Z1uH6XTNHeS5b/9S/ajgshgS6aSVlGpCvWJ8EJmOkpm
 Q+a0ZEEJcaqcdfwfHBTDnDm/Yxl+vXqF4mhZYS50Kgsl9z+3y1ZIPK5YOj6RdQxpOB9uCuI
 SSkigJEbHa2gjUiatoU0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b8UDEti39Ts=;snWGwqAm5Ggde0HWeQ/++G0J6+e
 TUuae+s5tliQH51P36T1odqt5nW9ViJ9ap0iNlk6oNITUgVeygBKJvvWz9PS/BKdOD+GFESKm
 Z9nAhU4LW5HXW/+/6iQAdsOS+AtWeer39UhnILwyICyJO0ACmUdx7aYSoSPRdUpYMxKmgkwIp
 bwiuP+cZ2/NoZEVRj8VSUVph6R0kwDhu8Nuw7AbnVFKFh1Lzc82QZgKJMC9V01wT+tgVBG/Bw
 H+W+JWU/S36f7aW1Ead45cUjKAMKesoD6QrUK3jysMn8Jus3CBYUx7gFAQDbYLHoNTS6oky3q
 FV9mGBX19CTY6tlYdsCOM9qoC6cRGuPu7TUZ/8N/eNjJouVIE6NtQqKawFQV5x5Cc2ABhsz4o
 uEwMBYfXSS/HuQrSAuMBowZVSqw9POLa1nOhR+N008FzYTHmVnJrExYsbGVNDXWuWqlvDVxzf
 Av45W7Sm6KMcHCJfXP+Lg4IEKSXGMh7Wa1dQLARYAM2tJtv1VG5zQ+yznYcoNgoYCwuEumO1e
 MtHslnxioFtgYPISrVK76c27s9EBbGyJNMNyUMzjjc9zFr7eZyKzqG2j/xz5cLjbKUZyC1KS7
 Ko2KIQ1s7thArQ/UWB3iWZuC/feA4AFh93WR1Nlg2OpEBANxppWUxeaWReUcOuGiOcHnCDd3v
 TMSb+fRI5EWubnQPUHyjQFAEcaxp58J47+rp8cyG5b3zqwG09+C+BIqLAWY0H9lY/FqYmD7rQ
 IByZZFpr1qcfnpGSPOKoyFTas8ZCsWx5qz6ucoAityw+rzFxBZypyiqCecIV7Duq/1d2o2X8a
 NG8CIDMPvwddzFm8eZ05pKkbh3nKHSbnO/8wSY0V5KTvA+K5MFRU1G2mSCc5DRVWfOZv0Dwz2
 qSmsbZDgTN+QO528TViVp/S6BeaKR/ihfdgRICeSutCoVLeWcCaitCf1uwRDrj2Lo2kXGN5IJ
 oGXOj/qBkqP7oQ/sOkWEpq5dDQhSmYpYckfB3+gkeimZA0XefJIhNwwNFt23XOWkcyXtZGbBk
 ZruIUNBV2+tGCgZ5Jh03hal7NgoeUSUG1K0yYK9p6+scXnMRhS+af1jjl0na0QFXf/31dCECB
 M2hxwcYUiVBVgr0kym1mlcyPRj9mkvJhWxDb/OYE+4/c81aOLC1Xim7lpbW0+Oy9IxYmW47A5
 ePztKoh6rg/ojnEjNK1r8rkagb07WXw5o6OITqAUfZ+YzQMdwgXm186USMQbYZUpLcKua/kEU
 cws6TmdZMRjlEopFkwD3bzkf6FweF6IE3WvBmo2h6DOjmS43PNKaK7iPyQy3lza8qTzZNtmEM
 czPvIdStDasyKz3nEPHE3zMuI2YxhiUotY5J0kDJc7EqVoIC6oPfm/kr/umnVKYlOM/KjgDUp
 9QgcWaVFNG6LY+mkrP7mwPOIGxw8EEIw/iP3TtsUtUKhBwuR6qbmH5Nx9vZAFatgvpepoCT/h
 1D8EgdR08KDNk/msEqv8bZfFYZtSAm2Z+vFcARM63G1tH5fbsiyvmq4qVicsHGcanUSji2LLF
 xwil890OFhDEyhq5pJYLokc23sOkM7M9IS4PWyuXEDEixw7NkFSEFl3+rWs2FYzx47+tNjc7G
 G4IhuMZ3nHS7ChDxPzSUrN+ZXimU4YhrH9N815ITKKie4zoAdAppD+Jy3qAdx08mN6Z38m1CS
 a3z2XmHBACwLmjhxQxgNYwaRD3u+nV1xGpAbaA9WA16coLqy1mfb0+o5hF0Qs/h0odUtI6wch
 zEFjhlr8JJ/PakuGc4M2/dznaaNb4hIHMb+VWOwLHBf4J94Is9wD2svvpTBF9lrRKziPGdxWT
 hka6Ko+v3dltJZ2LKAv6o08CKg/3SWbZw7y/+kAz/k0oWmtJ8/jobgjnrN5LJLWF5yF6cuC8s
 dhEzd+pWXUGbdSCRRiiql+vitJCkQqnhIJjFAby6kNbjwnNzzB8QPSU7jARxyfhvwklxmd5jW
 8G4QzgGjipHnNADxGcKGsdaEG4nn/f60bLqvVmH2hQuwEOdmqmt1qsiqvP1Mmq2d7Up1UKdEN
 3/kOxoSj5EkVQBTZFkfXApzymlXI1Plh8H9m5XKi8N4Kwi4FV0O6zl58w2vtAaqPha71ydRm1
 h4r2FUbmvoyOKsqbIkxhJgvSN3kUHd/Y2mdaaAZJoxH2mxQ6sdRex8Ahb3EtyE/k7ikJJ4srh
 lmSOS0l9SRJdYtNgkdMPwtPHe3U8IU0KQlkSugOWUu264RExePqeaUwbp2Y7vhY229PRopmsA
 SB+Xms0lLLO1m9v8lUB1FG6w5Wc1fWTQr0brGU+hWqvHwra06HbP5O0QQIGwtVN08dRfGKaUn
 06OS0IfhiAUmj0RjOr9rh/bDvE2NyFyD/U0Q9CsvZAzD/2B4BA3sNmqUGWrvzyFRq0Kjs25Sx
 xGr1OV/8z5fuokrb4UDS5CWctoQ8QpyFLaoRCCIgxXzywVH0djtqvZs+dCwzw5vkZjsUMNEPP
 IJ9HLjW0Lzx11WUiJztmdT6sgxpEc0/9I+MD1X8ZykWC9z+gTzmAHyAR/0MAolgmzuSxcXsSJ
 m1j0Z5gzvOKPceqJAmuZRJ07xNRi3LAvutKI4zB5w4OS3PetuMp1pnBfDESXFt4/LEsURoz3h
 Z9pyccPEJTaOEnfqN31mBdH/jv7hDOJSu98/2ylIw2/lq+w+Yp/hxvoZ0bpl3/9XMfIvOLaz9
 fIk0xI55juKKZ6nHFvdF3Xk32VJkIiWzEdG6F/agq0siPHUppQU+SYAY+G/cCZaNy1+KokcS8
 NIRT/Af4ZyowwDfaQA4/QswVFWSrejUjyMFSm9hkcPFufq2MuXiFHYBmWFEW/Eog/Yq06Vv+w
 c0S6AtyV1eF0n8MvGMLdOOKtHVWy3qBrFVj9POxcWPCXajBXRuWKJmkgnLtNR8QCI2JVisEvh
 LRnzx2SofxblhOT9BxWrRsiubMHk7iUGJNj9rTAcA5LSV2lNmD6OGzlYX76ORgx3Ks9RcnYBq
 1wujuXUZDRWnuwEO14uzxT1P+ZV0tKX6Fhvdjb8u9FDmflNZev2fg5iS6NL1+kw9KxcA/yF3k
 bpfc+8fXaK42NfjhBK9xk5q0Rf7VCZpJE7mWN9+aqxpiol21u/OtM39IobEd5jgAyinczpgwR
 tEaaVmnVP7x/QdRU6dQcZ3CZh00+jEl/r2PB3abwY2vM3/w9YRQ90njwgIYPNVyoCyQ88GJSw
 Jfka54JSzokbzAT/WomMfd1wBaKlKyFwZj4sui5Cz/vgs5YobJ7YDMJUhClBbzpxa+RdfMpuM
 JZYo7M4mmVAD31hglOzkEtw3U+H3VEV3NHUNkGgR9UXwNJ1TkWj6GBcufduLSmZOVJkRiotJI
 mSuUYUzAF+ewIgMZtnXlYKMtdHDlIL3HS7ZKPevFrtGDHYv2/e+f+Ih1zXK9uzSAtgu5eJ3g0
 PBCLpthzIVgTxstEKlUyKUxS/Ha5FguS5yORsrMA6LhL7EmQ//2D1DirgwcRPL

Currently the driver is not able to handle the case that a SPI device
specifies a higher spi-max-frequency than half of per-clk:

    per-clk should be at least two times of transfer speed

Fix this by clamping to the max possible value and use the minimum SCK
period of 2 cycles.

Fixes: 77736a98b859 ("spi: lpspi: add the error info of transfer speed set=
ting")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/spi/spi-fsl-lpspi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 67d4000c3cef..313e444a34f3 100644
=2D-- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -330,13 +330,11 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_da=
ta *fsl_lpspi)
 	}
=20
 	if (config.speed_hz > perclk_rate / 2) {
-		dev_err(fsl_lpspi->dev,
-		      "per-clk should be at least two times of transfer speed");
-		return -EINVAL;
+		div =3D 2;
+	} else {
+		div =3D DIV_ROUND_UP(perclk_rate, config.speed_hz);
 	}
=20
-	div =3D DIV_ROUND_UP(perclk_rate, config.speed_hz);
-
 	for (prescale =3D 0; prescale <=3D prescale_max; prescale++) {
 		scldiv =3D div / (1 << prescale) - 2;
 		if (scldiv >=3D 0 && scldiv < 256) {
=2D-=20
2.34.1


