Return-Path: <linux-spi+bounces-7408-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E17BA7D54F
	for <lists+linux-spi@lfdr.de>; Mon,  7 Apr 2025 09:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA13172DAB
	for <lists+linux-spi@lfdr.de>; Mon,  7 Apr 2025 07:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8452248AD;
	Mon,  7 Apr 2025 07:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XR1zCoOb"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992CC33CA;
	Mon,  7 Apr 2025 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744010140; cv=none; b=Ix4TP6JpQPkOkkX3DS3FbWWdkEzkZRcyRocQMkkKqYH8oo0+Qa0fMrkbeKOy56sR0xQy+H7/9M/a76ZGOVV6qlCtqoOge0Fy9HBNAPANb9nVTbR32B6hD+GaHREIa6QPsliNxKrzyWO9Ie4N30s60mp1QKb98fyEjJmuUntBZ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744010140; c=relaxed/simple;
	bh=aV+OM30NsD1e5RDVkL6nJ9ny7KHTplFE3n3NrsR0Xsk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f/bHQ/Wssu4nsyJ+Vv/pwdwrLd12UxOyz25fMjpftshj4PFi2g9LQkVM7n+scFVbapfFq55FDnxWPLzm8qto5V258TeMgg251tBhnsYIaPdvVsviGK2nTldDEJ3HrhEB3mSN093PYy3H24uUxNULH2WARbN7Ils3PmQOamIFrpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XR1zCoOb; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 958A544341;
	Mon,  7 Apr 2025 07:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744010129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a9JaBGMTvb/hYdR9v/xSYDOC5vbqVFIgbLcpRT30azE=;
	b=XR1zCoObjM/6L9ZAQT5P66rnf8wNnoiQWu7VeLQKYAyekbF1ApgeQ6BWIzmdGa2RVyTH49
	v7Zw1qYD749WcPLoSklgxIq9hZ6LAS0GSFFVYQ5LO0UCLs9lY7LkM5vNPDMHJQczLsKXVA
	6+3v6JehYuGhsJyDEaM+tVirhOBv/KkNWUjBw/8yW92jR5SwLLHU+2wqzpWMt6OJVJ9l/K
	5chll1oDEaqpiM0jmKz+m3bHopg1RNy9ayHCeEndR6D/OWjCK8hbdnH9zaKWMYtiRiK3wH
	wUGJcdnLiRgo5OlkecwVlLFxkfVyHitMyR6647jBQyTLjmx9iXfsg7+hdjaaLg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Mark Brown <broonie@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
In-Reply-To: <99eef91c334f3f2314c2f5671e1eb55211a5ff19.1743150196.git.geert+renesas@glider.be>
References: <99eef91c334f3f2314c2f5671e1eb55211a5ff19.1743150196.git.geert+renesas@glider.be>
Subject: Re: [PATCH] mtd: nand: Drop explicit test for built-in
 CONFIG_SPI_QPIC_SNAND
Message-Id: <174401012746.998658.11206994348683987630.b4-ty@bootlin.com>
Date: Mon, 07 Apr 2025 09:15:27 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleelheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevjghfuffkffggtgfgofesthekredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehieffhfeulefgtdeltefgleevgffgheduledvheduudelgfehlefgheeivedvgeenucfkphepledvrddukeegrddutdekrdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrddukeegrddutdekrdefpdhhvghloheplgduledvrdduieekrddurddutdeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepqhhuihgtpghmuggrlhgrmhesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehgvggvrhhtodhrvghnvghsrghssehglhhiuggvrhdrsggvpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehquhhitggpvhgrrhgruggrsehquhhitghinhgtr
 dgtohhmpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 28 Mar 2025 09:24:01 +0100, Geert Uytterhoeven wrote:
> If CONFIG_SPI_QPIC_SNAND=m, but CONFIG_MTD_NAND_QCOM=n:
> 
>     ERROR: modpost: "qcom_nandc_unalloc" [drivers/spi/spi-qpic-snand.ko] undefined!
>     ...
> 
> Fix this by dropping the explicit test for a built-in
> CONFIG_SPI_QPIC_SNAND completely.  Kbuild handles multiple and mixed
> obj-y/obj-m rules for the same object file fine.
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: nand: Drop explicit test for built-in CONFIG_SPI_QPIC_SNAND
      commit: 36c6468724aa98d33fea9a1d7e07ddda6302f5d4

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


