Return-Path: <linux-spi+bounces-8795-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA76DAEB068
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 09:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C171C2358E
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 07:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B19C18A6DB;
	Fri, 27 Jun 2025 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=growora.pl header.i=@growora.pl header.b="debohDHT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.growora.pl (mail.growora.pl [51.254.119.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1E21C6BE
	for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.254.119.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010366; cv=none; b=tU5YisbRJnLHCPaaQbwoN1Z6Tkgc+ukJx8ksLifakGvp5DLflsS6Dg0drgTvHf4HsWSy5YCDxiZSL1TaK0Bc+l4oCTrxDSJk+Yek6j/TceTGNhJFvbF72RMZIp44iG0I5SutvQ7k1OMunpK01INoADvQzrNX9h/R6Ce3gojErtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010366; c=relaxed/simple;
	bh=EB99enkNQ3/lKc2PdUObvM5/Gi3NF8gZrWwaTOp5KYs=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=aMZO3pcQnSTzXcyDhP1jpcCsslP42qGmWAfZcAdUOlhBmsL8OJD+LDSraruziS87ulNWqHyIMm3I+C4ncJzs1KYnJ47rpupefN3YrxO+zlyJRB9KVMs2XZSP5xabGGf2bRioI7TC0xvme61jdMaXSoQW5BybrXqSS7x2hgf4XRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=growora.pl; spf=pass smtp.mailfrom=growora.pl; dkim=pass (2048-bit key) header.d=growora.pl header.i=@growora.pl header.b=debohDHT; arc=none smtp.client-ip=51.254.119.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=growora.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=growora.pl
Received: by mail.growora.pl (Postfix, from userid 1002)
	id 190742392F; Fri, 27 Jun 2025 09:45:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=growora.pl; s=mail;
	t=1751010358; bh=EB99enkNQ3/lKc2PdUObvM5/Gi3NF8gZrWwaTOp5KYs=;
	h=Date:From:To:Subject:From;
	b=debohDHTcAtLFrI11NrjMLHw/ndNdyIsfW2NkiMyxjhRWDQG4Gc5FFXZFKp6JkRIa
	 oBh1wCUblc+FPpFz7gshC5+od8TEiaeLoDwveEdbD7prKVyg9+OaDoy/CjNWYeY92T
	 DGvLeLo+avuT9UaFiM9G8/VC9mnYxYCAGIgXA1+KSN2mGbyq2OBaJ/mc7r4+T/rQVA
	 2Yd+nAO8BInpVVCZtQujddgNgXuixswPWFPtHMNW0SGWAo/3SpXPQ5532JzrFN7vkY
	 yjL0OEKZrQcGlDI24RvcG63CUcPpG+W5b5YNrJDKN7Vf15lKM8G3rbT6QMPN8TFION
	 LAKDEYz5R0QZg==
Received: by mail.growora.pl for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 07:45:48 GMT
Message-ID: <20250627084500-0.1.ka.21k9f.0.79r80391ia@growora.pl>
Date: Fri, 27 Jun 2025 07:45:48 GMT
From: "Mateusz Hopczak" <mateusz.hopczak@growora.pl>
To: <linux-spi@vger.kernel.org>
Subject: IT bez rekrutacji
X-Mailer: mail.growora.pl
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cze=C5=9B=C4=87,

wiem, =C5=BCe rozw=C3=B3j oprogramowania to dzi=C5=9B nie tylko kwestia t=
echnologii, ale tempa i dost=C4=99pno=C5=9Bci odpowiednich ludzi.=20

Je=C5=9Bli temat dotyczy r=C3=B3wnie=C5=BC Pa=C5=84stwa zespo=C5=82u, by=C4=
=87 mo=C5=BCe warto porozmawia=C4=87 o wsp=C3=B3=C5=82pracy, w kt=C3=B3re=
j to my przejmujemy ca=C5=82y proces tworzenia oprogramowania =E2=80=93 o=
d analizy po utrzymanie. Pracujemy elastycznie, dostosowuj=C4=85c si=C4=99=
 do wewn=C4=99trznych procedur i Waszego stacku technologicznego.

Dzia=C5=82amy tak, jakby=C5=9Bmy byli cz=C4=99=C5=9Bci=C4=85 zespo=C5=82u=
, ale bez operacyjnego ci=C4=99=C5=BCaru, ryzyka kosztownych rekrutacji, =
z elastycznym podej=C5=9Bciem i transparentnym modelem rozlicze=C5=84.

Czy jeste=C5=9Bcie Pa=C5=84stwo zainteresowani pog=C5=82=C4=99bieniem tem=
atu?


Pozdrawiam
Mateusz Hopczak

