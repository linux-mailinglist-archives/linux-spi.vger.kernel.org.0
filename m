Return-Path: <linux-spi+bounces-10549-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D78BCE66B
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 21:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A397119A83BF
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 19:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9DE301030;
	Fri, 10 Oct 2025 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkHJT9ZL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A45D271A71;
	Fri, 10 Oct 2025 19:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124745; cv=none; b=nyed247r6nJsQPOc/Y2uAkvCVJdKsg32HVgVB+NdLliBpmNWGYGR4i1nZ2CgT9j8hT8h51IoLRMTE4CZkEKFoe9pmqphC5Tf63fzEe38BoGHm6DECyZSjwc4umY2hX6HZBfpfLvrDnUKnB0ZQ+PbOOtD/75Zwkqcl7YG2CltC0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124745; c=relaxed/simple;
	bh=+7hfgnuMOn7PjhV9yACuuzeiQWR/GFPo/rbdazp9pN8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=sEygypfsIsMuejluYC93hkfhFQ6sy0rDhj7sm6DGPVFKY3r6Y4gQfDahWBBhR+Uhu1RcQpR1InLYgBJVUJpSPVuuLfU3uzf0E/8zIeOdVKuvEWBaeJbqQ0T03aiDmulD1IjbQXM2DAXXYrAQ6OxNy8pTYrognP8/7sMb7UG8n1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkHJT9ZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70321C4CEF1;
	Fri, 10 Oct 2025 19:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760124743;
	bh=+7hfgnuMOn7PjhV9yACuuzeiQWR/GFPo/rbdazp9pN8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=QkHJT9ZL3bT8GOLNy1LizxBfaS2ebvRwdmL/eyu+ldmDw/ElQd0JFAodh2PqepyZN
	 ooI7IMJKsO2CHNRqK37EdPEOi/TfYT095cS5DX2cZsiRBDRubnaK2VxSj7qJXFblqr
	 ujEmXvGvT70UdK3p5EyN+kbfTiv9JM6gDXaWppN5Gzd+/Mub8HHqIwTCR3iDOcf+Qu
	 8TvLU1rca0MwZNH9lSRDtYLdRjoNOHnUoAMuaBTOKATYH+eTGSN5089skbrrpLq2cT
	 eF+ifjGdciHjKQVwCA/GzljXj9uWmXtcx3hzL2r6ZGDWZ1UyXv+vpErdD2g7dzqLsY
	 yD+BAFlNqziKA==
Date: Fri, 10 Oct 2025 14:32:21 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-mediatek@lists.infradead.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Andreas Gnau <andreas.gnau@iopsys.eu>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Ray Liu <ray.liu@airoha.com>, Conor Dooley <conor+dt@kernel.org>, 
 Andy Shevchenko <andy@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
Message-Id: <176012464351.894208.475126102183552810.robh@kernel.org>
Subject: Re: [PATCH v7 00/17] spi: airoha: driver fixes & improvements


On Fri, 10 Oct 2025 06:31:19 +0300, Mikhail Kshevetskiy wrote:
> This patch series greatly improve airoha snfi driver and fix a
> number of serious bugs.
> 
> Fixed bugs:
>  * Fix reading/writing of flashes with more than one plane per lun
>  * Fill the buffer with 0xff before writing
>  * Fix reading of flashes supporting continuous reading mode
>  * Fix error paths
> 
> Improvements:
>  * Add support of dual/quad wires spi modes in exec_op(). This also
>    fix flash reading/writing if dirmap can't be created.
>  * Support of dualio/quadio flash reading commands
>  * Remove dirty hack that reads flash page settings from SNFI registers
>    during driver startup
>  * Add support of EN7523 SoC
> 
> Patched kernel tests:
> 
>     root@OpenWrt:/lib/modules/6.6.79# insmod mtd_oobtest.ko dev=1
>     [  263.191711]
>     [  263.193218] =================================================
>     [  263.199014] mtd_oobtest: MTD device: 1
>     [  263.202768] mtd_oobtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
>     [  263.216791] mtd_test: scanning for bad eraseblocks
>     [  263.221956] mtd_test: scanned 2047 eraseblocks, 0 are bad
>     [  263.227361] mtd_oobtest: test 1 of 5
>     [  265.077216] mtd_oobtest: writing OOBs of whole device
>     [  265.121767] mtd_oobtest: written up to eraseblock 0
>     [  275.174147] mtd_oobtest: written up to eraseblock 256
>     [  285.210279] mtd_oobtest: written up to eraseblock 512
>     [  295.241724] mtd_oobtest: written up to eraseblock 768
>     [  305.280167] mtd_oobtest: written up to eraseblock 1024
>     [  315.326883] mtd_oobtest: written up to eraseblock 1280
>     [  325.364049] mtd_oobtest: written up to eraseblock 1536
>     [  335.398609] mtd_oobtest: written up to eraseblock 1792
>     [  345.358981] mtd_oobtest: written 2047 eraseblocks
>     [  345.363694] mtd_oobtest: verifying all eraseblocks
>     [  345.386088] mtd_oobtest: verified up to eraseblock 0
>     [  349.830833] mtd_oobtest: verified up to eraseblock 256
>     [  354.276245] mtd_oobtest: verified up to eraseblock 512
>     [  358.721496] mtd_oobtest: verified up to eraseblock 768
>     [  363.166881] mtd_oobtest: verified up to eraseblock 1024
>     [  367.612694] mtd_oobtest: verified up to eraseblock 1280
>     [  372.058211] mtd_oobtest: verified up to eraseblock 1536
>     [  376.503820] mtd_oobtest: verified up to eraseblock 1792
>     [  380.914843] mtd_oobtest: verified 2047 eraseblocks
>     [  380.919660] mtd_oobtest: test 2 of 5
>     [  384.202620] mtd_oobtest: writing OOBs of whole device
>     [  384.247584] mtd_oobtest: written up to eraseblock 0
>     [  394.305121] mtd_oobtest: written up to eraseblock 256
>     [  404.342199] mtd_oobtest: written up to eraseblock 512
>     [  414.374204] mtd_oobtest: written up to eraseblock 768
>     [  424.409891] mtd_oobtest: written up to eraseblock 1024
>     [  434.453378] mtd_oobtest: written up to eraseblock 1280
>     [  444.494321] mtd_oobtest: written up to eraseblock 1536
>     [  454.534480] mtd_oobtest: written up to eraseblock 1792
>     [  464.490962] mtd_oobtest: written 2047 eraseblocks
>     [  464.495681] mtd_oobtest: verifying all eraseblocks
>     [  464.518015] mtd_oobtest: verified up to eraseblock 0
>     [  468.955635] mtd_oobtest: verified up to eraseblock 256
>     [  473.395502] mtd_oobtest: verified up to eraseblock 512
>     [  477.834373] mtd_oobtest: verified up to eraseblock 768
>     [  482.272717] mtd_oobtest: verified up to eraseblock 1024
>     [  486.712148] mtd_oobtest: verified up to eraseblock 1280
>     [  491.150704] mtd_oobtest: verified up to eraseblock 1536
>     [  495.589439] mtd_oobtest: verified up to eraseblock 1792
>     [  499.993138] mtd_oobtest: verified 2047 eraseblocks
>     [  499.997951] mtd_oobtest: test 3 of 5
>     [  503.404228] mtd_oobtest: writing OOBs of whole device
>     [  503.448822] mtd_oobtest: written up to eraseblock 0
>     [  513.480773] mtd_oobtest: written up to eraseblock 256
>     [  523.489361] mtd_oobtest: written up to eraseblock 512
>     [  533.506896] mtd_oobtest: written up to eraseblock 768
>     [  543.506268] mtd_oobtest: written up to eraseblock 1024
>     [  553.506503] mtd_oobtest: written up to eraseblock 1280
>     [  563.511266] mtd_oobtest: written up to eraseblock 1536
>     [  573.519567] mtd_oobtest: written up to eraseblock 1792
>     [  583.455111] mtd_oobtest: written 2047 eraseblocks
>     [  583.459837] mtd_oobtest: verifying all eraseblocks
>     [  583.499358] mtd_oobtest: verified up to eraseblock 0
>     [  592.382953] mtd_oobtest: verified up to eraseblock 256
>     [  601.267297] mtd_oobtest: verified up to eraseblock 512
>     [  610.150907] mtd_oobtest: verified up to eraseblock 768
>     [  619.034702] mtd_oobtest: verified up to eraseblock 1024
>     [  627.919683] mtd_oobtest: verified up to eraseblock 1280
>     [  636.821168] mtd_oobtest: verified up to eraseblock 1536
>     [  645.705487] mtd_oobtest: verified up to eraseblock 1792
>     [  654.520336] mtd_oobtest: verified 2047 eraseblocks
>     [  654.525134] mtd_oobtest: test 4 of 5
>     [  657.578146] mtd_oobtest: attempting to start write past end of OOB
>     [  657.584336] mtd_oobtest: an error is expected...
>     [  657.588974] mtd_oobtest: error occurred as expected
>     [  657.593848] mtd_oobtest: attempting to start read past end of OOB
>     [  657.599953] mtd_oobtest: an error is expected...
>     [  657.604569] mtd_oobtest: error occurred as expected
>     [  657.609450] mtd_oobtest: attempting to write past end of device
>     [  657.615367] mtd_oobtest: an error is expected...
>     [  657.619990] mtd_oobtest: error occurred as expected
>     [  657.624864] mtd_oobtest: attempting to read past end of device
>     [  657.630715] mtd_oobtest: an error is expected...
>     [  657.635333] mtd_oobtest: error occurred as expected
>     [  657.641043] mtd_oobtest: attempting to write past end of device
>     [  657.646966] mtd_oobtest: an error is expected...
>     [  657.651574] mtd_oobtest: error occurred as expected
>     [  657.656451] mtd_oobtest: attempting to read past end of device
>     [  657.662277] mtd_oobtest: an error is expected...
>     [  657.666901] mtd_oobtest: error occurred as expected
>     [  657.671774] mtd_oobtest: test 5 of 5
>     [  659.382333] mtd_oobtest: writing OOBs of whole device
>     [  659.388056] mtd_oobtest: written up to eraseblock 0
>     [  659.393526] mtd_oobtest: written up to eraseblock 0
>     [  659.704525] mtd_oobtest: written up to eraseblock 256
>     [  659.710187] mtd_oobtest: written up to eraseblock 256
>     [  660.021093] mtd_oobtest: written up to eraseblock 512
>     [  660.026752] mtd_oobtest: written up to eraseblock 512
>     [  660.338427] mtd_oobtest: written up to eraseblock 768
>     [  660.344048] mtd_oobtest: written up to eraseblock 768
>     [  660.655718] mtd_oobtest: written up to eraseblock 1024
>     [  660.661462] mtd_oobtest: written up to eraseblock 1024
>     [  660.970676] mtd_oobtest: written up to eraseblock 1280
>     [  660.976386] mtd_oobtest: written up to eraseblock 1280
>     [  661.286858] mtd_oobtest: written up to eraseblock 1536
>     [  661.292587] mtd_oobtest: written up to eraseblock 1536
>     [  661.605397] mtd_oobtest: written up to eraseblock 1792
>     [  661.611142] mtd_oobtest: written up to eraseblock 1792
>     [  661.918754] mtd_oobtest: written 2046 eraseblocks
>     [  661.923458] mtd_oobtest: verifying all eraseblocks
>     [  661.928812] mtd_oobtest: verified up to eraseblock 0
>     [  662.072499] mtd_oobtest: verified up to eraseblock 256
>     [  662.216152] mtd_oobtest: verified up to eraseblock 512
>     [  662.359956] mtd_oobtest: verified up to eraseblock 768
>     [  662.503238] mtd_oobtest: verified up to eraseblock 1024
>     [  662.646847] mtd_oobtest: verified up to eraseblock 1280
>     [  662.790603] mtd_oobtest: verified up to eraseblock 1536
>     [  662.934269] mtd_oobtest: verified up to eraseblock 1792
>     [  663.076329] mtd_oobtest: verified 2046 eraseblocks
>     [  663.081114] mtd_oobtest: finished with 0 errors
>     [  663.085647] =================================================
> 
>     root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_pagetest.ko dev=1
>     [ 1142.213082]
>     [ 1142.214590] =================================================
>     [ 1142.220433] mtd_pagetest: MTD device: 1
>     [ 1142.224278] mtd_pagetest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
>     [ 1142.238388] mtd_test: scanning for bad eraseblocks
>     [ 1142.243536] mtd_test: scanned 2047 eraseblocks, 0 are bad
>     [ 1142.248935] mtd_pagetest: erasing whole device
>     [ 1143.962562] mtd_pagetest: erased 2047 eraseblocks
>     [ 1143.967301] mtd_pagetest: writing whole device
>     [ 1144.011729] mtd_pagetest: written up to eraseblock 0
>     [ 1154.137933] mtd_pagetest: written up to eraseblock 256
>     [ 1164.265201] mtd_pagetest: written up to eraseblock 512
>     [ 1174.393365] mtd_pagetest: written up to eraseblock 768
>     [ 1184.525700] mtd_pagetest: written up to eraseblock 1024
>     [ 1194.650920] mtd_pagetest: written up to eraseblock 1280
>     [ 1204.773676] mtd_pagetest: written up to eraseblock 1536
>     [ 1214.896934] mtd_pagetest: written up to eraseblock 1792
>     [ 1224.942600] mtd_pagetest: written 2047 eraseblocks
>     [ 1224.947410] mtd_pagetest: verifying all eraseblocks
>     [ 1225.053133] mtd_pagetest: verified up to eraseblock 0
>     [ 1250.760034] mtd_pagetest: verified up to eraseblock 256
>     [ 1276.448242] mtd_pagetest: verified up to eraseblock 512
>     [ 1302.138825] mtd_pagetest: verified up to eraseblock 768
>     [ 1327.824020] mtd_pagetest: verified up to eraseblock 1024
>     [ 1353.532178] mtd_pagetest: verified up to eraseblock 1280
>     [ 1379.234385] mtd_pagetest: verified up to eraseblock 1536
>     [ 1404.943865] mtd_pagetest: verified up to eraseblock 1792
>     [ 1430.468816] mtd_pagetest: verified 2047 eraseblocks
>     [ 1430.473702] mtd_pagetest: crosstest
>     [ 1430.477717] mtd_pagetest: reading page at 0x0
>     [ 1430.482328] mtd_pagetest: reading page at 0xffdf800
>     [ 1430.487469] mtd_pagetest: reading page at 0x0
>     [ 1430.492084] mtd_pagetest: verifying pages read at 0x0 match
>     [ 1430.497668] mtd_pagetest: crosstest ok
>     [ 1430.501409] mtd_pagetest: erasecrosstest
>     [ 1430.505323] mtd_pagetest: erasing block 0
>     [ 1430.511511] mtd_pagetest: writing 1st page of block 0
>     [ 1430.517166] mtd_pagetest: reading 1st page of block 0
>     [ 1430.522505] mtd_pagetest: verifying 1st page of block 0
>     [ 1430.527739] mtd_pagetest: erasing block 0
>     [ 1430.532565] mtd_pagetest: writing 1st page of block 0
>     [ 1430.538229] mtd_pagetest: erasing block 2046
>     [ 1430.544181] mtd_pagetest: reading 1st page of block 0
>     [ 1430.549498] mtd_pagetest: verifying 1st page of block 0
>     [ 1430.554718] mtd_pagetest: erasecrosstest ok
>     [ 1430.558900] mtd_pagetest: erasetest
>     [ 1430.562381] mtd_pagetest: erasing block 0
>     [ 1430.567208] mtd_pagetest: writing 1st page of block 0
>     [ 1430.572858] mtd_pagetest: erasing block 0
>     [ 1430.577680] mtd_pagetest: reading 1st page of block 0
>     [ 1430.582990] mtd_pagetest: verifying 1st page of block 0 is all 0xff
>     [ 1430.589279] mtd_pagetest: erasetest ok
>     [ 1430.593023] mtd_pagetest: finished with 0 errors
>     [ 1430.597651] =================================================
> 
>     root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_readtest.ko dev=1
>     [ 1478.691648]
>     [ 1478.693158] =================================================
>     [ 1478.698981] mtd_readtest: MTD device: 1
>     [ 1478.702829] mtd_readtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
>     [ 1478.716939] mtd_test: scanning for bad eraseblocks
>     [ 1478.722072] mtd_test: scanned 2047 eraseblocks, 0 are bad
>     [ 1478.727475] mtd_readtest: testing page read
>     [ 1548.352125] mtd_readtest: finished
>     [ 1548.355553] =================================================
> 
>     root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_speedtest.ko dev=1
>     [ 1617.353002]
>     [ 1617.354511] =================================================
>     [ 1617.360332] mtd_speedtest: MTD device: 1
>     [ 1617.364258] mtd_speedtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
>     [ 1617.380150] mtd_test: scanning for bad eraseblocks
>     [ 1617.385428] mtd_test: scanned 2047 eraseblocks, 0 are bad
>     [ 1621.021861] mtd_speedtest: testing eraseblock write speed
>     [ 1700.915306] mtd_speedtest: eraseblock write speed is 3279 KiB/s
>     [ 1700.921250] mtd_speedtest: testing eraseblock read speed
>     [ 1734.931886] mtd_speedtest: eraseblock read speed is 7705 KiB/s
>     [ 1738.682742] mtd_speedtest: testing page write speed
>     [ 1818.818644] mtd_speedtest: page write speed is 3269 KiB/s
>     [ 1818.824058] mtd_speedtest: testing page read speed
>     [ 1852.913595] mtd_speedtest: page read speed is 7687 KiB/s
>     [ 1856.674492] mtd_speedtest: testing 2 page write speed
>     [ 1936.437284] mtd_speedtest: 2 page write speed is 3285 KiB/s
>     [ 1936.442869] mtd_speedtest: testing 2 page read speed
>     [ 1970.498124] mtd_speedtest: 2 page read speed is 7694 KiB/s
>     [ 1970.503624] mtd_speedtest: Testing erase speed
>     [ 1974.343389] mtd_speedtest: erase speed is 68316 KiB/s
>     [ 1974.348479] mtd_speedtest: Testing 2x multi-block erase speed
>     [ 1976.068855] mtd_speedtest: 2x multi-block erase speed is 152811 KiB/s
>     [ 1976.075309] mtd_speedtest: Testing 4x multi-block erase speed
>     [ 1977.790232] mtd_speedtest: 4x multi-block erase speed is 153301 KiB/s
>     [ 1977.796693] mtd_speedtest: Testing 8x multi-block erase speed
>     [ 1979.511905] mtd_speedtest: 8x multi-block erase speed is 153273 KiB/s
>     [ 1979.518367] mtd_speedtest: Testing 16x multi-block erase speed
>     [ 1981.230700] mtd_speedtest: 16x multi-block erase speed is 153539 KiB/s
>     [ 1981.237249] mtd_speedtest: Testing 32x multi-block erase speed
>     [ 1982.948381] mtd_speedtest: 32x multi-block erase speed is 153648 KiB/s
>     [ 1982.954918] mtd_speedtest: Testing 64x multi-block erase speed
>     [ 1984.665992] mtd_speedtest: 64x multi-block erase speed is 153655 KiB/s
>     [ 1984.672531] mtd_speedtest: finished
>     [ 1984.676054] =================================================
> 
>     root@OpenWrt:/lib/modules/6.6.79# insmod mtd_stresstest.ko dev=1
>     [ 2190.651750]
>     [ 2190.653263] =================================================
>     [ 2190.659087] mtd_stresstest: MTD device: 1
>     [ 2190.663105] mtd_stresstest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
>     [ 2190.679846] mtd_test: scanning for bad eraseblocks
>     [ 2190.684981] mtd_test: scanned 2047 eraseblocks, 0 are bad
>     [ 2190.690389] mtd_stresstest: doing operations
>     [ 2190.694655] mtd_stresstest: 0 operations done
>     [ 2214.262705] mtd_stresstest: 1024 operations done
>     [ 2239.019612] mtd_stresstest: 2048 operations done
>     [ 2262.820899] mtd_stresstest: 3072 operations done
>     [ 2285.061376] mtd_stresstest: 4096 operations done
>     [ 2308.297322] mtd_stresstest: 5120 operations done
>     [ 2330.530459] mtd_stresstest: 6144 operations done
>     [ 2352.651759] mtd_stresstest: 7168 operations done
>     [ 2375.188275] mtd_stresstest: 8192 operations done
>     [ 2397.738174] mtd_stresstest: 9216 operations done
>     [ 2414.792572] mtd_stresstest: finished, 10000 operations done
>     [ 2414.798257] =================================================
> 
> Speed test of original driver (with patch to fix support of flashes
> with more than one plane per lun)
> 
>     root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_speedtest.ko dev=1
>     [ 2894.142208]
>     [ 2894.143719] =================================================
>     [ 2894.149556] mtd_speedtest: MTD device: 1
>     [ 2894.153486] mtd_speedtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
>     [ 2894.168888] mtd_test: scanning for bad eraseblocks
>     [ 2894.174023] mtd_test: scanned 2047 eraseblocks, 0 are bad
>     [ 2897.500416] mtd_speedtest: testing eraseblock write speed
>     [ 2977.807233] mtd_speedtest: eraseblock write speed is 3262 KiB/s
>     [ 2977.813171] mtd_speedtest: testing eraseblock read speed
>     [ 3013.906597] mtd_speedtest: eraseblock read speed is 7260 KiB/s
>     [ 3017.440320] mtd_speedtest: testing page write speed
>     [ 3097.833394] mtd_speedtest: page write speed is 3259 KiB/s
>     [ 3097.838812] mtd_speedtest: testing page read speed
>     [ 3134.004981] mtd_speedtest: page read speed is 7245 KiB/s
>     [ 3137.538423] mtd_speedtest: testing 2 page write speed
>     [ 3217.906288] mtd_speedtest: 2 page write speed is 3260 KiB/s
>     [ 3217.911883] mtd_speedtest: testing 2 page read speed
>     [ 3254.049757] mtd_speedtest: 2 page read speed is 7251 KiB/s
>     [ 3254.055254] mtd_speedtest: Testing erase speed
>     [ 3257.599146] mtd_speedtest: erase speed is 74027 KiB/s
>     [ 3257.604213] mtd_speedtest: Testing 2x multi-block erase speed
>     [ 3259.320945] mtd_speedtest: 2x multi-block erase speed is 153139 KiB/s
>     [ 3259.327413] mtd_speedtest: Testing 4x multi-block erase speed
>     [ 3261.044585] mtd_speedtest: 4x multi-block erase speed is 153098 KiB/s
>     [ 3261.051047] mtd_speedtest: Testing 8x multi-block erase speed
>     [ 3262.786520] mtd_speedtest: 8x multi-block erase speed is 151479 KiB/s
>     [ 3262.792979] mtd_speedtest: Testing 16x multi-block erase speed
>     [ 3264.509898] mtd_speedtest: 16x multi-block erase speed is 153130 KiB/s
>     [ 3264.516454] mtd_speedtest: Testing 32x multi-block erase speed
>     [ 3266.233403] mtd_speedtest: 32x multi-block erase speed is 153125 KiB/s
>     [ 3266.239961] mtd_speedtest: Testing 64x multi-block erase speed
>     [ 3267.957985] mtd_speedtest: 64x multi-block erase speed is 153029 KiB/s
>     [ 3267.964525] mtd_speedtest: finished
>     [ 3267.968039] =================================================
> 
> It looks like a patched driver is a bit faster
> 
> write speed: 3260 KiB/s  vs  3277 KiB/s
> read speed:  7252 KiB/s  vs  7695 KiB/s
> 
> Changes v2:
>  * minor fix
>  * add comments to code
> 
> Changes v3:
>  * add patch to prevent continuous reading
> 
> Changes v4:
>  * removed non-needed patch, other patch was a bit updated
>  * treat zero buswidth as single wire buswidth (thanks to Jyothi Kumar Seerapu)
>  * changes were tested with linux
>  * test results was added
> 
> Changes v5:
>  * reorder patches a bit
>  * improve description of some patches
>  * minor fixes & improvements
> 
> Changes v6:
>  * do not fill with 0xff the whole write buffer, only areas not covered
>    by user provided data are filled now.
> 
> Changes v7:
>  * add EN7523 SoC support
>  * add en7523 specific hack to avoid flash data damaging if UART_TX pin
>    was short to ground during boot
>  * add SNAND node to en7523.dtsi
>  * update dt-bindings
> 
> Mikhail Kshevetskiy (17):
>   spi: airoha: return an error for continuous mode dirmap creation cases
>   spi: airoha: remove unnecessary restriction length
>   spi: airoha: add support of dual/quad wires spi modes to exec_op()
>     handler
>   spi: airoha: remove unnecessary switch to non-dma mode
>   spi: airoha: switch back to non-dma mode in the case of error
>   spi: airoha: fix reading/writing of flashes with more than one plane
>     per lun
>   spi: airoha: unify dirmap read/write code
>   spi: airoha: support of dualio/quadio flash reading commands
>   spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
>   spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and
>     REG_SPI_NFI_SECCUS_SIZE registers
>   spi: airoha: set custom sector size equal to flash page size
>   spi: airoha: avoid reading flash page settings from SNFI registers
>     during driver startup
>   spi: airoha: buffer must be 0xff-ed before writing
>   spi: airoha-snfi: make compatible with EN7523 SoC
>   spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was
>     short to GND
>   dt-bindings: spi: airoha: add compatible for EN7523
>   arm: dts: airoha: en7523: add SNAND node
> 
>  .../bindings/spi/airoha,en7581-snand.yaml     |   5 +-
>  arch/arm/boot/dts/airoha/en7523.dtsi          |  21 +
>  drivers/spi/spi-airoha-snfi.c                 | 552 ++++++++++--------
>  3 files changed, 327 insertions(+), 251 deletions(-)
> 
> --
> 2.51.0
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/next-20251009 (exact match)
 Base: tags/next-20251009 (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/airoha/' for 20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu:

arch/arm/boot/dts/airoha/en7523.dtsi:207.36-225.4: Warning (spi_bus_bridge): /spi_controller@1fa10000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/airoha/en7523-evb.dtb: Warning (spi_bus_reg): Failed prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/airoha/en7523-evb.dtb: spi_controller@1fa10000 (airoha,en7523-snand): $nodename:0: 'spi_controller@1fa10000' does not match '^spi(@.*|-([0-9]|[1-9][0-9]+))?$'
	from schema $id: http://devicetree.org/schemas/spi/airoha,en7581-snand.yaml#
arch/arm/boot/dts/airoha/en7523-evb.dtb: spi_controller@1fa10000 (airoha,en7523-snand): Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'nand@0' were unexpected)
	from schema $id: http://devicetree.org/schemas/spi/airoha,en7581-snand.yaml#






