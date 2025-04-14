Return-Path: <linux-spi+bounces-7569-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D64A87B63
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 11:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C161818836FB
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 09:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306F725E443;
	Mon, 14 Apr 2025 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UMQffY0Y"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D8B259CA4;
	Mon, 14 Apr 2025 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744621492; cv=none; b=ia8etcHAgBYCNZLjkhl349RJwUd0n86JzM7QXcZFUXLHukDjdL7aGF2t+VGy6moNrhpB0dyGwVqeqWvPh/zgDM+5L2yUSBEImJOl9+Y6G/VLIYRTLg3pDvaQxa4JNkuJ+Y/4Xdj5ZUmgDEVUkfRqLjdfz4x+TVPtkpRL5B4+m6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744621492; c=relaxed/simple;
	bh=VkgWh8fHdxfZghfLXtADSZaxTp3bEfee++iyxI23+PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UXU759yVWz8Yz6OOqtyyMvW6eoosUcCdMKH/gPmlH2QIKqJt5DAddQAaTpJ9DgqLBz9XqBKtvVipdRE65bX0u+uSh8iA89gmW0BlnFVZakXPwXBaa8f7q4U+AyiZ4zHziNRbCmvM0Pit8LnPcdJDTT0rMXRZXnapjutkVn3CI8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UMQffY0Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DK7apW007124;
	Mon, 14 Apr 2025 09:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qWeIftUqA7jWcE1yp2JuYYMKDxEXUWoRSywTQ1SU8z0=; b=UMQffY0Y495wm1cV
	O6j+A7ngvkTFoOj9js7MqW2XVQUax7t0G681Q08k+6OFyUdrGYN76rwSgAVw7u4K
	trCCM2UuLVBYAmXmPze+N8ZZXYsGpzK4S9SbBYn1VmDIjhvZAOSqkwyKgNo3jhfH
	zUaneI74hciFUELURdq8RFnUgCXKwRktDmw9FCmbAtHzRiYQOj64SwxlpUpn157a
	zTGduw3WAqopZjImkpXGt/1Yz6FkxrldkL9taPiKM/sY+Vas/LtDo3zM8/MwCiIn
	qtt7QMx4MIHm2nTrXsu1vxRnFunnwvGcKrcXfC2raTk5hkwHKni/JYB0TWdN8vOo
	Phwmiw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydvj44d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 09:04:34 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53E94XhG013725
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 09:04:33 GMT
Received: from [10.217.219.207] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 14 Apr
 2025 02:04:29 -0700
Message-ID: <20c8df59-6e36-48a4-ba98-e1006de9e09b@quicinc.com>
Date: Mon, 14 Apr 2025 14:34:26 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] ASoC: renesas: rsnd: allow to use ADG only
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jaroslav
 Kysela <perex@perex.cz>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring
	<robh@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        <devicetree@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-spi@vger.kernel.org>
References: <87h62vh5mj.wl-kuninori.morimoto.gx@renesas.com>
 <87bjt3h5lc.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <87bjt3h5lc.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=ZIrXmW7b c=1 sm=1 tr=0 ts=67fccfa2 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=yC-0_ovQAAAA:8 a=_P2YCQLOWNFUlFncCNoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bTcI2Mr-JVBXktXIw4RGWQwqpitO5Khr
X-Proofpoint-ORIG-GUID: bTcI2Mr-JVBXktXIw4RGWQwqpitO5Khr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=833
 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140065



On 4/11/2025 6:33 AM, Kuninori Morimoto wrote:
> Audio clock generator (= ADG) can be used standalone, but current driver
> will be error in such use case. Makes it as not error.
will be error ?
Makes it as not error ?

I could not get exact problem here. seems you need to write properly.
> And, current driver registers it as fixed rate clock, but actual clkout
> was handled when SSI start works. Setup clkout setting when it was probed.
> Otherwise it can't be used ADG only.
> 
Same here, its not clearly explaining.
> Because of this fixup, current rsnd_adg_get_clkout() function name will be
> strange. Rename get -> init.
> 
same here too. Please write in some verbose which says something.
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   sound/soc/renesas/rcar/adg.c  | 28 ++++++++++++++++------------
>   sound/soc/renesas/rcar/core.c |  7 ++++++-
>   2 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/sound/soc/renesas/rcar/adg.c b/sound/soc/renesas/rcar/adg.c
> index 191f212d338c..db980e4642b8 100644
> --- a/sound/soc/renesas/rcar/adg.c
> +++ b/sound/soc/renesas/rcar/adg.c
> @@ -377,16 +377,9 @@ int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *ssi_mod, unsigned int rate)
>   int rsnd_adg_clk_control(struct rsnd_priv *priv, int enable)
>   {
>   	struct rsnd_adg *adg = rsnd_priv_to_adg(priv);
> -	struct rsnd_mod *adg_mod = rsnd_mod_get(adg);
>   	struct clk *clk;
>   	int ret = 0, i;
>   
> -	if (enable) {
> -		rsnd_mod_bset(adg_mod, BRGCKR, 0x80770000, adg->ckr);
> -		rsnd_mod_write(adg_mod, BRRA,  adg->brga);
> -		rsnd_mod_write(adg_mod, BRRB,  adg->brgb);
> -	}
> -
>   	for_each_rsnd_clkin(clk, adg, i) {
>   		if (enable) {
>   			ret = clk_prepare_enable(clk);
> @@ -504,13 +497,14 @@ static void rsnd_adg_unregister_clkout(struct rsnd_priv *priv)
>   		clk_unregister_fixed_rate(clk);
>   }
>   
> -static int rsnd_adg_get_clkout(struct rsnd_priv *priv)
> +static int rsnd_adg_init_clkout(struct rsnd_priv *priv)
>   {
>   	struct rsnd_adg *adg = priv->adg;
>   	struct clk *clk;
>   	struct device *dev = rsnd_priv_to_dev(priv);
>   	struct device_node *np = dev->of_node;
>   	struct property *prop;
> +	struct rsnd_mod *adg_mod = rsnd_mod_get(adg);
>   	u32 ckr, brgx, brga, brgb;
>   	u32 req_rate[ADG_HZ_SIZE] = {};
>   	uint32_t count = 0;
> @@ -537,7 +531,7 @@ static int rsnd_adg_get_clkout(struct rsnd_priv *priv)
>   	 */
>   	prop = of_find_property(np, "clock-frequency", NULL);
>   	if (!prop)
> -		goto rsnd_adg_get_clkout_end;
> +		goto rsnd_adg_init_clkout_end;
>   
>   	req_size = prop->length / sizeof(u32);
>   	if (req_size > ADG_HZ_SIZE) {
> @@ -633,7 +627,7 @@ static int rsnd_adg_get_clkout(struct rsnd_priv *priv)
>   
>   	if (!(adg->brg_rate[ADG_HZ_48]  && req_Hz[ADG_HZ_48]) &&
>   	    !(adg->brg_rate[ADG_HZ_441] && req_Hz[ADG_HZ_441]))
> -		goto rsnd_adg_get_clkout_end;
> +		goto rsnd_adg_init_clkout_end;
>   
>   	if (approximate)
>   		dev_info(dev, "It uses CLK_I as approximate rate");
> @@ -682,11 +676,21 @@ static int rsnd_adg_get_clkout(struct rsnd_priv *priv)
>   				    &adg->onecell);
>   	}
>   
> -rsnd_adg_get_clkout_end:
> +rsnd_adg_init_clkout_end:
>   	adg->ckr = ckr;
>   	adg->brga = brga;
>   	adg->brgb = brgb;
>   
> +	/*
> +	 * setup default clkout
> +	 */
> +	if (0 == (req_rate[0] % 8000))
> +		ckr = 0x80000000; /* use BRGB output */
> +
> +	rsnd_mod_bset(adg_mod, BRGCKR, 0x80770000, adg->ckr | ckr);
> +	rsnd_mod_write(adg_mod, BRRA,  adg->brga);
> +	rsnd_mod_write(adg_mod, BRRB,  adg->brgb);
> +
>   	return 0;
>   
>   err:
> @@ -764,7 +768,7 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
>   	if (ret)
>   		return ret;
>   
> -	ret = rsnd_adg_get_clkout(priv);
> +	ret = rsnd_adg_init_clkout(priv);
>   	if (ret)
>   		return ret;
>   
> diff --git a/sound/soc/renesas/rcar/core.c b/sound/soc/renesas/rcar/core.c
> index 30afc942d381..4f4ed24cb361 100644
> --- a/sound/soc/renesas/rcar/core.c
> +++ b/sound/soc/renesas/rcar/core.c
> @@ -1482,8 +1482,13 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
>   	int dai_i;
>   
>   	nr = rsnd_dai_of_node(priv, &is_graph);
> +
> +	/*
> +	 * There is a case that it is used only for ADG (Sound Clock).
> +	 * No DAI is not error
> +	 */
>   	if (!nr)
> -		return -EINVAL;
> +		return 0;
>   
>   	rdrv = devm_kcalloc(dev, nr, sizeof(*rdrv), GFP_KERNEL);
>   	rdai = devm_kcalloc(dev, nr, sizeof(*rdai), GFP_KERNEL);


