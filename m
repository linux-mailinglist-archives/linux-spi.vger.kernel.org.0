Return-Path: <linux-spi+bounces-7884-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88FFAA91EF
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 13:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3921D3BC681
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 11:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EA0201270;
	Mon,  5 May 2025 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K3dkW2Lz"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747C420127B;
	Mon,  5 May 2025 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746443852; cv=none; b=lcepvBjY0xK4vapStr/CuFjITNkCJiAjKEIYHguTlaEd3VnXh7MOHmXPemZ/dgchxAbciYg7chqHZekLyMBEXkIzbgSg5b6kQXyf7kltB8EadCldoIUzBoZOOQkb9Let5InW35eBcPtY1upMgF76wIKfOkSMjRp1XM+ynw2Oa3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746443852; c=relaxed/simple;
	bh=WgdK9COX2/YN5qcLheLbkdLvP4w6M5/jdEAl9Pq8mik=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kxSam7SomaXJAktKx6uYxpOV4zmGGfP4NFZ/Ve0zOrpcVIBlQ5fJ44b9GtSrXc6qXpBajfJKeAX4Rj8WF1wnh23MlrnKdarkh01ihooaTPHi4DsZhut8z11J/PzypUSQOps0hauvx/ajuoCFDkS62rFrSMrCL03ouue6QOufDhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K3dkW2Lz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5450rcaZ000439;
	Mon, 5 May 2025 11:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sce1n6nYEDj8whhsIhFwKfjHNOo5EQdFM1/P/ZcBQDI=; b=K3dkW2LzjjtKAbWM
	fKpV1ineVhMf5IhASdNVEmqF2/23AZO26R0tWu4bY0RuXLDvNFihtWnnB52CWC0T
	UBqXw3SO4bR7BlvvLvSB6eEao2q+vdpB0xfBGXEIbFr0yokCrWTOvuXPcNnTjvkh
	odk7yYQXAxJ4xCeA4A98lLqqjwuF6tb3f/dm38sU240M42HKM73hA4dV0qPnYymQ
	vtaEQNC4xdNXKW7/f39YUvDO/cm5vc1oRTO9sZ/althXfnLXXLGGnzFoDskn/+He
	YBd4FlowiwSPjZJ00cSIiVA/jdZBi0FSUB46Ol8FttQh8dbP+fsqpYhqq4RHJx4N
	8sLD+w==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46dce9bt1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 11:17:18 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 545BHH2A011675
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 May 2025 11:17:17 GMT
Received: from [10.152.201.53] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 5 May 2025
 04:17:12 -0700
Message-ID: <8aa3d4da-da3e-2af4-e0f9-cd56d6259d8f@quicinc.com>
Date: Mon, 5 May 2025 16:47:09 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH next 2/2] spi: spi-qpic-snand: add support for 8 bits ECC
 strength
Content-Language: en-US
To: Gabor Juhos <j4g8y7@gmail.com>, Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Miquel Raynal
	<miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "Vignesh
 Raghavendra" <vigneshr@ti.com>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan Ramabadhran
	<quic_srichara@quicinc.com>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250502-qpic-snand-8bit-ecc-v1-0-95f3cd08bbc5@gmail.com>
 <20250502-qpic-snand-8bit-ecc-v1-2-95f3cd08bbc5@gmail.com>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20250502-qpic-snand-8bit-ecc-v1-2-95f3cd08bbc5@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDEwNyBTYWx0ZWRfX0koTvaHjC/wW
 KTvP3wL1pjDKieKi+hMyhXVaNfQBi62ZQD+FFFeeRYHQwcE68lChplb9w+vpQc2rhIvRiO6koDa
 8fh+c2h54uqgwgsyZYrWtAK+93RDWdi/zFutGKzsE4CbOxMzcJJbJRw7QkegBlqHN4cMgRM1EQE
 Mc8WB/ok2NgucHgPawVgKUBXs+2rVAKXgjbcYCuiAiompfr0x0WfiWyYr2QBUcT0LgWzA3nVFKN
 abeppkSXNAfF7nGx2u0cJGWiQo3zqkMbjitswEupQLKJkcsFpWH12B7Tq9e3hj9mjiy+oiIhVwE
 HFOp4qzv/yzZgG5n1bZbsVBUOt/zY0F7RRIeMRL39GdV73JfYayx+WHJlt30/unYyMCT4uJu2oX
 BvhS9Q7hpFpNeFDGDBV8cD0LOkTRctZ1PVW5xxnyTBcposp13pRFTQPPeqtd5CF8NBToniO+
X-Proofpoint-ORIG-GUID: -46UvJVAFOLQGBFEwHTn765jo_wEMhj3
X-Authority-Analysis: v=2.4 cv=Qope3Uyd c=1 sm=1 tr=0 ts=68189e3e cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8
 a=jFRyK2_P28nSYqVi4BUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -46UvJVAFOLQGBFEwHTn765jo_wEMhj3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_05,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050107



On 5/3/2025 1:01 AM, Gabor Juhos wrote:
> Even though the hardware supports 8 bits ECC strength, but that is not
> handled in the driver yet. This change adds the missing bits in order
> to allow using the driver with chips which require 8 bits ECC strength.
> 
> No functional changes intended with regard to the existing 4 bits ECC
> strength support.
> 
> Tested on an IPQ9574 platform using a GigaDevice GD5F2GM7REYIG chip.
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
> mtdtest results:
> 
>    # dmesg | grep nand
>    [    0.678143] spi-nand spi0.0: GigaDevice SPI NAND was found.
>    [    0.687393] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
>    # cat /proc/mtd
>    dev:    size   erasesize  name
>    mtd0: 10000000 00020000 "spi0.0"
>    # insmod mtd_test
>    # insmod mtd_speedtest dev=0
>    [   63.128425]
>    [   63.128452] =================================================
>    [   63.128979] mtd_speedtest: MTD device: 0
>    [   63.134622] mtd_speedtest: MTD device size 268435456, eraseblock size 131072, page size 2048, count of eraseblocks 2048, pages per eraseblock 64, OOB size 128
>    [   63.139561] mtd_test: scanning for bad eraseblocks
>    [   63.756447] mtd_test: scanned 2048 eraseblocks, 0 are bad
>    [   71.085514] mtd_speedtest: testing eraseblock write speed
>    [  202.745977] mtd_speedtest: eraseblock write speed is 1991 KiB/s
>    [  202.746022] mtd_speedtest: testing eraseblock read speed
>    [  284.104591] mtd_speedtest: eraseblock read speed is 3222 KiB/s
>    [  291.405533] mtd_speedtest: testing page write speed
>    [  422.516341] mtd_speedtest: page write speed is 1999 KiB/s
>    [  422.516384] mtd_speedtest: testing page read speed
>    [  504.144630] mtd_speedtest: page read speed is 3211 KiB/s
>    [  511.476726] mtd_speedtest: testing 2 page write speed
>    [  643.114443] mtd_speedtest: 2 page write speed is 1991 KiB/s
>    [  643.114485] mtd_speedtest: testing 2 page read speed
>    [  724.434752] mtd_speedtest: 2 page read speed is 3223 KiB/s
>    [  724.434796] mtd_speedtest: Testing erase speed
>    [  731.792729] mtd_speedtest: erase speed is 35648 KiB/s
>    [  731.792772] mtd_speedtest: Testing 2x multi-block erase speed
>    [  739.162513] mtd_speedtest: 2x multi-block erase speed is 35589 KiB/s
>    [  739.162558] mtd_speedtest: Testing 4x multi-block erase speed
>    [  746.486241] mtd_speedtest: 4x multi-block erase speed is 35820 KiB/s
>    [  746.486287] mtd_speedtest: Testing 8x multi-block erase speed
>    [  753.789683] mtd_speedtest: 8x multi-block erase speed is 35919 KiB/s
>    [  753.789728] mtd_speedtest: Testing 16x multi-block erase speed
>    [  761.093075] mtd_speedtest: 16x multi-block erase speed is 35920 KiB/s
>    [  761.093120] mtd_speedtest: Testing 32x multi-block erase speed
>    [  768.396145] mtd_speedtest: 32x multi-block erase speed is 35922 KiB/s
>    [  768.396222] mtd_speedtest: Testing 64x multi-block erase speed
>    [  775.699819] mtd_speedtest: 64x multi-block erase speed is 35918 KiB/s
>    [  775.699863] mtd_speedtest: finished
>    [  775.705259] =================================================
>    # insmod mtd_readtest dev=0
>    [  919.060671]
>    [  919.060699] =================================================
>    [  919.061226] mtd_readtest: MTD device: 0
>    [  919.066957] mtd_readtest: MTD device size 268435456, eraseblock size 131072, page size 2048, count of eraseblocks 2048, pages per eraseblock 64, OOB size 128
>    [  919.070556] mtd_test: scanning for bad eraseblocks
>    [  919.086016] mtd_test: scanned 2048 eraseblocks, 0 are bad
>    [  919.089465] mtd_readtest: testing page read
>    [ 1090.778227] mtd_readtest: finished
>    [ 1090.778286] =================================================
>    # insmod mtd_pagetest dev=0
>    [ 1216.297313]
>    [ 1216.297341] =================================================
>    [ 1216.297867] mtd_pagetest: MTD device: 0
>    [ 1216.303509] mtd_pagetest: MTD device size 268435456, eraseblock size 131072, page size 2048, count of eraseblocks 2048, pages per eraseblock 64, OOB size 128
>    [ 1216.307213] mtd_test: scanning for bad eraseblocks
>    [ 1216.322680] mtd_test: scanned 2048 eraseblocks, 0 are bad
>    [ 1216.326077] mtd_pagetest: erasing whole device
>    [ 1223.694968] mtd_pagetest: erased 2048 eraseblocks
>    [ 1223.695009] mtd_pagetest: writing whole device
>    [ 1223.763930] mtd_pagetest: written up to eraseblock 0
>    [ 1240.268942] mtd_pagetest: written up to eraseblock 256
>    [ 1256.641498] mtd_pagetest: written up to eraseblock 512
>    [ 1273.139048] mtd_pagetest: written up to eraseblock 768
>    [ 1289.718929] mtd_pagetest: written up to eraseblock 1024
>    [ 1306.244553] mtd_pagetest: written up to eraseblock 1280
>    [ 1322.939723] mtd_pagetest: written up to eraseblock 1536
>    [ 1339.246937] mtd_pagetest: written up to eraseblock 1792
>    [ 1355.613729] mtd_pagetest: written 2048 eraseblocks
>    [ 1355.613770] mtd_pagetest: verifying all eraseblocks
>    [ 1355.854290] mtd_pagetest: verified up to eraseblock 0
>    [ 1416.657733] mtd_pagetest: verified up to eraseblock 256
>    [ 1477.384593] mtd_pagetest: verified up to eraseblock 512
>    [ 1538.008142] mtd_pagetest: verified up to eraseblock 768
>    [ 1599.080797] mtd_pagetest: verified up to eraseblock 1024
>    [ 1660.775431] mtd_pagetest: verified up to eraseblock 1280
>    [ 1722.177149] mtd_pagetest: verified up to eraseblock 1536
>    [ 1783.090166] mtd_pagetest: verified up to eraseblock 1792
>    [ 1844.450757] mtd_pagetest: verified 2048 eraseblocks
>    [ 1844.450798] mtd_pagetest: crosstest
>    [ 1844.455676] mtd_pagetest: reading page at 0x0
>    [ 1844.458603] mtd_pagetest: reading page at 0xffff800
>    [ 1844.463047] mtd_pagetest: reading page at 0x0
>    [ 1844.467790] mtd_pagetest: verifying pages read at 0x0 match
>    [ 1844.471636] mtd_pagetest: crosstest ok
>    [ 1844.477062] mtd_pagetest: erasecrosstest
>    [ 1844.480833] mtd_pagetest: erasing block 0
>    [ 1844.488498] mtd_pagetest: writing 1st page of block 0
>    [ 1844.489821] mtd_pagetest: reading 1st page of block 0
>    [ 1844.494475] mtd_pagetest: verifying 1st page of block 0
>    [ 1844.498942] mtd_pagetest: erasing block 0
>    [ 1844.507505] mtd_pagetest: writing 1st page of block 0
>    [ 1844.509042] mtd_pagetest: erasing block 2047
>    [ 1844.516725] mtd_pagetest: reading 1st page of block 0
>    [ 1844.518087] mtd_pagetest: verifying 1st page of block 0
>    [ 1844.522415] mtd_pagetest: erasecrosstest ok
>    [ 1844.527495] mtd_pagetest: erasetest
>    [ 1844.531613] mtd_pagetest: erasing block 0
>    [ 1844.538671] mtd_pagetest: writing 1st page of block 0
>    [ 1844.540249] mtd_pagetest: erasing block 0
>    [ 1844.547869] mtd_pagetest: reading 1st page of block 0
>    [ 1844.548927] mtd_pagetest: verifying 1st page of block 0 is all 0xff
>    [ 1844.553326] mtd_pagetest: erasetest ok
>    [ 1844.559440] mtd_pagetest: finished with 0 errors
>    [ 1844.563233] =================================================
>    # insmod mtd_subpagetest dev=0
>    [ 1942.429708]
>    [ 1942.429736] =================================================
>    [ 1942.430262] mtd_subpagetest: MTD device: 0
>    [ 1942.435905] mtd_subpagetest: MTD device size 268435456, eraseblock size 131072, page size 2048, subpage size 2048, count of eraseblocks 2048, pages per eraseblock 64, OOB size 128
>    [ 1942.439994] mtd_test: scanning for bad eraseblocks
>    [ 1942.457111] mtd_test: scanned 2048 eraseblocks, 0 are bad
>    [ 1949.824564] mtd_subpagetest: writing whole device
>    [ 1949.826670] mtd_subpagetest: written up to eraseblock 0
>    [ 1950.351816] mtd_subpagetest: written up to eraseblock 256
>    [ 1950.875797] mtd_subpagetest: written up to eraseblock 512
>    [ 1951.399912] mtd_subpagetest: written up to eraseblock 768
>    [ 1951.923618] mtd_subpagetest: written up to eraseblock 1024
>    [ 1952.447361] mtd_subpagetest: written up to eraseblock 1280
>    [ 1952.970834] mtd_subpagetest: written up to eraseblock 1536
>    [ 1953.494635] mtd_subpagetest: written up to eraseblock 1792
>    [ 1954.016265] mtd_subpagetest: written 2048 eraseblocks
>    [ 1954.016294] mtd_subpagetest: verifying all eraseblocks
>    [ 1954.021617] mtd_subpagetest: verified up to eraseblock 0
>    [ 1954.347458] mtd_subpagetest: verified up to eraseblock 256
>    [ 1954.667446] mtd_subpagetest: verified up to eraseblock 512
>    [ 1954.987343] mtd_subpagetest: verified up to eraseblock 768
>    [ 1955.307385] mtd_subpagetest: verified up to eraseblock 1024
>    [ 1955.627462] mtd_subpagetest: verified up to eraseblock 1280
>    [ 1955.947277] mtd_subpagetest: verified up to eraseblock 1536
>    [ 1956.266834] mtd_subpagetest: verified up to eraseblock 1792
>    [ 1956.585581] mtd_subpagetest: verified 2048 eraseblocks
>    [ 1963.889308] mtd_subpagetest: verifying all eraseblocks for 0xff
>    [ 1963.930487] mtd_subpagetest: verified up to eraseblock 0
>    [ 1974.592567] mtd_subpagetest: verified up to eraseblock 256
>    [ 1985.180953] mtd_subpagetest: verified up to eraseblock 512
>    [ 1995.805397] mtd_subpagetest: verified up to eraseblock 768
>    [ 2006.348859] mtd_subpagetest: verified up to eraseblock 1024
>    [ 2016.900530] mtd_subpagetest: verified up to eraseblock 1280
>    [ 2027.447587] mtd_subpagetest: verified up to eraseblock 1536
>    [ 2037.962383] mtd_subpagetest: verified up to eraseblock 1792
>    [ 2048.587863] mtd_subpagetest: verified 2048 eraseblocks
>    [ 2048.587906] mtd_subpagetest: writing whole device
>    [ 2048.648174] mtd_subpagetest: written up to eraseblock 0
>    [ 2062.643145] mtd_subpagetest: written up to eraseblock 256
>    [ 2076.699015] mtd_subpagetest: written up to eraseblock 512
>    [ 2091.004910] mtd_subpagetest: written up to eraseblock 768
>    [ 2105.149879] mtd_subpagetest: written up to eraseblock 1024
>    [ 2119.470691] mtd_subpagetest: written up to eraseblock 1280
>    [ 2133.746861] mtd_subpagetest: written up to eraseblock 1536
>    [ 2147.776477] mtd_subpagetest: written up to eraseblock 1792
>    [ 2161.947734] mtd_subpagetest: written 2048 eraseblocks
>    [ 2161.947776] mtd_subpagetest: verifying all eraseblocks
>    [ 2161.986109] mtd_subpagetest: verified up to eraseblock 0
>    [ 2170.818316] mtd_subpagetest: verified up to eraseblock 256
>    [ 2179.596875] mtd_subpagetest: verified up to eraseblock 512
>    [ 2188.405116] mtd_subpagetest: verified up to eraseblock 768
>    [ 2197.188588] mtd_subpagetest: verified up to eraseblock 1024
>    [ 2206.002204] mtd_subpagetest: verified up to eraseblock 1280
>    [ 2214.784815] mtd_subpagetest: verified up to eraseblock 1536
>    [ 2223.557141] mtd_subpagetest: verified up to eraseblock 1792
>    [ 2232.472832] mtd_subpagetest: verified 2048 eraseblocks
>    [ 2239.818213] mtd_subpagetest: verifying all eraseblocks for 0xff
>    [ 2239.861404] mtd_subpagetest: verified up to eraseblock 0
>    [ 2250.439035] mtd_subpagetest: verified up to eraseblock 256
>    [ 2261.176485] mtd_subpagetest: verified up to eraseblock 512
>    [ 2271.713183] mtd_subpagetest: verified up to eraseblock 768
>    [ 2282.356892] mtd_subpagetest: verified up to eraseblock 1024
>    [ 2292.891424] mtd_subpagetest: verified up to eraseblock 1280
>    [ 2303.543110] mtd_subpagetest: verified up to eraseblock 1536
>    [ 2314.116690] mtd_subpagetest: verified up to eraseblock 1792
>    [ 2324.607804] mtd_subpagetest: verified 2048 eraseblocks
>    [ 2324.607846] mtd_subpagetest: finished with 0 errors
>    [ 2324.611859] =================================================
>    # insmod mtd_oobtest dev=0
>    [ 2336.159109]
>    [ 2336.159138] =================================================
>    [ 2336.159664] mtd_oobtest: MTD device: 0
>    [ 2336.165308] mtd_oobtest: MTD device size 268435456, eraseblock size 131072, page size 2048, count of eraseblocks 2048, pages per eraseblock 64, OOB size 128
>    [ 2336.169043] mtd_test: scanning for bad eraseblocks
>    [ 2336.184354] mtd_test: scanned 2048 eraseblocks, 0 are bad
>    [ 2336.187716] mtd_oobtest: test 1 of 5
>    [ 2343.495966] mtd_oobtest: writing OOBs of whole device
>    [ 2343.496073] mtd_oobtest: written up to eraseblock 0
>    [ 2343.516803] mtd_oobtest: written up to eraseblock 256
>    [ 2343.533527] mtd_oobtest: written up to eraseblock 512
>    [ 2343.549945] mtd_oobtest: written up to eraseblock 768
>    [ 2343.563666] mtd_oobtest: written up to eraseblock 1024
>    [ 2343.575186] mtd_oobtest: written up to eraseblock 1280
>    [ 2343.584310] mtd_oobtest: written up to eraseblock 1536
>    [ 2343.593011] mtd_oobtest: written up to eraseblock 1792
>    [ 2343.600847] mtd_oobtest: written 2048 eraseblocks
>    [ 2343.600861] mtd_oobtest: verifying all eraseblocks
>    [ 2343.604542] mtd_oobtest: verified up to eraseblock 0
>    [ 2343.616606] mtd_oobtest: verified up to eraseblock 256
>    [ 2343.623992] mtd_oobtest: verified up to eraseblock 512
>    [ 2343.631390] mtd_oobtest: verified up to eraseblock 768
>    [ 2343.638788] mtd_oobtest: verified up to eraseblock 1024
>    [ 2343.646184] mtd_oobtest: verified up to eraseblock 1280
>    [ 2343.653570] mtd_oobtest: verified up to eraseblock 1536
>    [ 2343.660970] mtd_oobtest: verified up to eraseblock 1792
>    [ 2343.668356] mtd_oobtest: verified 2048 eraseblocks
>    [ 2343.668369] mtd_oobtest: test 2 of 5
>    [ 2350.985635] mtd_oobtest: writing OOBs of whole device
>    [ 2350.985743] mtd_oobtest: written up to eraseblock 0
>    [ 2351.006445] mtd_oobtest: written up to eraseblock 256
>    [ 2351.023170] mtd_oobtest: written up to eraseblock 512
>    [ 2351.039645] mtd_oobtest: written up to eraseblock 768
>    [ 2351.053395] mtd_oobtest: written up to eraseblock 1024
>    [ 2351.064954] mtd_oobtest: written up to eraseblock 1280
>    [ 2351.074144] mtd_oobtest: written up to eraseblock 1536
>    [ 2351.082848] mtd_oobtest: written up to eraseblock 1792
>    [ 2351.090707] mtd_oobtest: written 2048 eraseblocks
>    [ 2351.090721] mtd_oobtest: verifying all eraseblocks
>    [ 2351.094373] mtd_oobtest: verified up to eraseblock 0
>    [ 2351.099353] mtd_oobtest: verified up to eraseblock 256
>    [ 2351.104460] mtd_oobtest: verified up to eraseblock 512
>    [ 2351.109437] mtd_oobtest: verified up to eraseblock 768
>    [ 2351.114528] mtd_oobtest: verified up to eraseblock 1024
>    [ 2351.119683] mtd_oobtest: verified up to eraseblock 1280
>    [ 2351.124772] mtd_oobtest: verified up to eraseblock 1536
>    [ 2351.129996] mtd_oobtest: verified up to eraseblock 1792
>    [ 2351.135187] mtd_oobtest: verified 2048 eraseblocks
>    [ 2351.140130] mtd_oobtest: test 3 of 5
>    [ 2358.448438] mtd_oobtest: writing OOBs of whole device
>    [ 2358.448546] mtd_oobtest: written up to eraseblock 0
>    [ 2358.469297] mtd_oobtest: written up to eraseblock 256
>    [ 2358.486095] mtd_oobtest: written up to eraseblock 512
>    [ 2358.501993] mtd_oobtest: written up to eraseblock 768
>    [ 2358.515473] mtd_oobtest: written up to eraseblock 1024
>    [ 2358.526708] mtd_oobtest: written up to eraseblock 1280
>    [ 2358.535426] mtd_oobtest: written up to eraseblock 1536
>    [ 2358.544152] mtd_oobtest: written up to eraseblock 1792
>    [ 2358.551732] mtd_oobtest: written 2048 eraseblocks
>    [ 2358.551744] mtd_oobtest: verifying all eraseblocks
>    [ 2358.555424] mtd_oobtest: verified up to eraseblock 0
>    [ 2358.567572] mtd_oobtest: verified up to eraseblock 256
>    [ 2358.575045] mtd_oobtest: verified up to eraseblock 512
>    [ 2358.582537] mtd_oobtest: verified up to eraseblock 768
>    [ 2358.590024] mtd_oobtest: verified up to eraseblock 1024
>    [ 2358.597511] mtd_oobtest: verified up to eraseblock 1280
>    [ 2358.604984] mtd_oobtest: verified up to eraseblock 1536
>    [ 2358.612468] mtd_oobtest: verified up to eraseblock 1792
>    [ 2358.619923] mtd_oobtest: verified 2048 eraseblocks
>    [ 2358.619936] mtd_oobtest: test 4 of 5
>    [ 2365.924669] mtd_oobtest: attempting to start write past end of OOB
>    [ 2365.924711] mtd_oobtest: an error is expected...
>    [ 2365.929795] mtd_oobtest: error occurred as expected
>    [ 2365.934520] mtd_oobtest: attempting to start read past end of OOB
>    [ 2365.939150] mtd_oobtest: an error is expected...
>    [ 2365.945371] mtd_oobtest: error occurred as expected
>    [ 2365.950087] mtd_oobtest: attempting to write past end of device
>    [ 2365.954660] mtd_oobtest: an error is expected...
>    [ 2365.960623] mtd_oobtest: error occurred as expected
>    [ 2365.965422] mtd_oobtest: attempting to read past end of device
>    [ 2365.970064] mtd_oobtest: an error is expected...
>    [ 2365.975925] mtd_oobtest: error occurred as expected
>    [ 2365.984256] mtd_oobtest: attempting to write past end of device
>    [ 2365.985300] mtd_oobtest: an error is expected...
>    [ 2365.991242] mtd_oobtest: error: wrote past end of device
>    [ 2365.996064] mtd_oobtest: attempting to read past end of device
>    [ 2366.001389] mtd_oobtest: an error is expected...
>    [ 2366.007028] mtd_oobtest: error: read past end of device
>    [ 2366.011776] mtd_oobtest: test 5 of 5
>    [ 2373.317991] mtd_oobtest: writing OOBs of whole device
>    [ 2373.318034] mtd_oobtest: written up to eraseblock 0
>    [ 2373.322028] mtd_oobtest: written up to eraseblock 0
>    [ 2373.327465] mtd_oobtest: written up to eraseblock 256
>    [ 2373.331576] mtd_oobtest: written up to eraseblock 256
>    [ 2373.337501] mtd_oobtest: written up to eraseblock 512
>    [ 2373.341820] mtd_oobtest: written up to eraseblock 512
>    [ 2373.347566] mtd_oobtest: written up to eraseblock 768
>    [ 2373.351888] mtd_oobtest: written up to eraseblock 768
>    [ 2373.357634] mtd_oobtest: written up to eraseblock 1024
>    [ 2373.361957] mtd_oobtest: written up to eraseblock 1024
>    [ 2373.367710] mtd_oobtest: written up to eraseblock 1280
>    [ 2373.372113] mtd_oobtest: written up to eraseblock 1280
>    [ 2373.377841] mtd_oobtest: written up to eraseblock 1536
>    [ 2373.382355] mtd_oobtest: written up to eraseblock 1536
>    [ 2373.387962] mtd_oobtest: written up to eraseblock 1792
>    [ 2373.392597] mtd_oobtest: written up to eraseblock 1792
>    [ 2373.398190] mtd_oobtest: written 2047 eraseblocks
>    [ 2373.402838] mtd_oobtest: verifying all eraseblocks
>    [ 2373.407629] mtd_oobtest: verified up to eraseblock 0
>    [ 2373.412483] mtd_oobtest: verified up to eraseblock 256
>    [ 2373.417625] mtd_oobtest: verified up to eraseblock 512
>    [ 2373.422518] mtd_oobtest: verified up to eraseblock 768
>    [ 2373.427650] mtd_oobtest: verified up to eraseblock 1024
>    [ 2373.432760] mtd_oobtest: verified up to eraseblock 1280
>    [ 2373.437912] mtd_oobtest: verified up to eraseblock 1536
>    [ 2373.443091] mtd_oobtest: verified up to eraseblock 1792
>    [ 2373.448337] mtd_oobtest: verified 2047 eraseblocks
>    [ 2373.453358] mtd_oobtest: finished with 2 errors
>    [ 2373.458250] =================================================
> 
> Note: the two errors are present even even without this patch when testing
> the driver with a flash chip requiring 4 bits ECC strength.
> 
>    # insmod mtd_stresstest dev=0
>    [ 2383.256453]
>    [ 2383.256482] =================================================
>    [ 2383.257008] mtd_stresstest: MTD device: 0
>    [ 2383.262650] mtd_stresstest: MTD device size 268435456, eraseblock size 131072, page size 2048, count of eraseblocks 2048, pages per eraseblock 64, OOB size 128
>    [ 2383.268254] mtd_test: scanning for bad eraseblocks
>    [ 2383.281992] mtd_test: scanned 2048 eraseblocks, 0 are bad
>    [ 2383.285565] mtd_stresstest: doing operations
>    [ 2383.291047] mtd_stresstest: 0 operations done
>    [ 2427.841267] mtd_stresstest: 1024 operations done
>    [ 2471.142229] mtd_stresstest: 2048 operations done
>    [ 2514.405277] mtd_stresstest: 3072 operations done
>    [ 2555.451926] mtd_stresstest: 4096 operations done
>    [ 2598.107133] mtd_stresstest: 5120 operations done
>    [ 2639.936952] mtd_stresstest: 6144 operations done
>    [ 2680.724751] mtd_stresstest: 7168 operations done
>    [ 2720.344163] mtd_stresstest: 8192 operations done
>    [ 2761.645640] mtd_stresstest: 9216 operations done
>    [ 2791.760534] mtd_stresstest: finished, 10000 operations done
>    [ 2791.760817] =================================================
>    #
Could you please run biterror test "mtd_nandbiterrs" with the same 
device, since you are adding 8-bit ECC support.

Regards,
Alam.


