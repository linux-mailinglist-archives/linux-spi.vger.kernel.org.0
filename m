Return-Path: <linux-spi+bounces-5889-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D7C9E266E
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2024 17:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30931B3945D
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2024 14:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D61F1F4277;
	Tue,  3 Dec 2024 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N1o4VhC2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040F71F427C;
	Tue,  3 Dec 2024 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235314; cv=none; b=dBXiTDMcrSMxe1yHWXOXD1D1wmJync2fk6nVvABge1Nk2XOZ9yJP23mCLn/4Xm3m3Pt+W/qh/ZVfKrivl5SvniOhSLAIVRsQvq/q+CSVih3XPz22pJ/0DnfGnV0DR2eAKUblZA8tE8tyyt8UjCseSjfjCDQx7bX9GZ9Dm5EHdkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235314; c=relaxed/simple;
	bh=2jX203YX84ritlNUy+v1E1INaBB/sf0hID3irOMOLzo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=HxIYOLcyy6YkJwHOxiRVCekNk7ZLSr530/UOmo2CEwoOeVo4BNu1i2ZHFBG71O9JRkZuxJ0XQBUNlXQob5qAFeFXMnB37LPwcYRr0p+vy4acrB0YW70YvvQHHMxi4KcY8PlQoWh7HndWdNwF7ffIuO2+nq5o9SL3E8Fv2H6v+qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N1o4VhC2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B37PraO017944;
	Tue, 3 Dec 2024 14:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tvgG8trdTiN/soQFzs7dfBWxVYWGArbsfDhV4LVl9/k=; b=N1o4VhC2uCFY8YlE
	Yn81UrhVzGEdP7+fZmhsbx09YHfvNkTDMb5RxVIy/AK8l5t6jwMVxD3UIwb/S3pF
	4jsY+N0xqWtFlnMSDFKXJV0Mkxzkb4dP19jJ+N0g2u2EM2QuJVl+qhYuRwTT4xmc
	r4+151brHvhAJ1ehJGN9yZYg0BLnMlF7HViLUZENhQZI9HVJcBy4ByDyFxIzXMVp
	H9hxNuocp59xMnq9EEyVtDsgVcqAD+9/DhQZeKvdJ8o0xaZ7ZN50Cm4y7U+JULLq
	BVK1wl9U1nndwfqihNRbQ62Q0nM4o9ocxIzMMJoDgVv3G/LYM2HLpUWalbIWOQOX
	Penz9g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437tstg95q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 14:15:07 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B3EF62t030342
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Dec 2024 14:15:06 GMT
Received: from [10.217.219.62] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Dec 2024
 06:15:03 -0800
Message-ID: <bb683a73-5d80-4a40-b554-b77b0aa17a7d@quicinc.com>
Date: Tue, 3 Dec 2024 19:44:55 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dmaengine: qcom: gpi: Add GPI immediate DMA
 support
From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>
References: <20241128133351.24593-1-quic_jseerapu@quicinc.com>
 <20241128133351.24593-2-quic_jseerapu@quicinc.com>
 <obv72hhaqvremd7b4c4efpqv6vy7blz54upwc7jqx3pvrzg24t@zebke7igb3nl>
 <1666035c-d674-43dd-bc33-83231d64e5f7@quicinc.com>
Content-Language: en-US
In-Reply-To: <1666035c-d674-43dd-bc33-83231d64e5f7@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kPECOWntndPu6smSnMTXJKWaT8TElIpw
X-Proofpoint-GUID: kPECOWntndPu6smSnMTXJKWaT8TElIpw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030121



On 11/29/2024 5:02 PM, Jyothi Kumar Seerapu wrote:
> 
> 
> On 11/28/2024 8:53 PM, Bjorn Andersson wrote:
>> On Thu, Nov 28, 2024 at 07:03:50PM +0530, Jyothi Kumar Seerapu wrote:
>>> The DMA TRE(Transfer ring element) buffer contains the DMA
>>> buffer address. Accessing data from this address can cause
>>> significant delays in SPI transfers, which can be mitigated to
>>> some extent by utilizing immediate DMA support.
>>>
>>> QCOM GPI DMA hardware supports an immediate DMA feature for data
>>> up to 8 bytes, storing the data directly in the DMA TRE buffer
>>> instead of the DMA buffer address. This enhancement enables faster
>>> SPI data transfers.
>>>
>>> This optimization reduces the average transfer time from 25 us to
>>> 16 us for a single SPI transfer of 8 bytes length, with a clock
>>> frequency of 50 MHz.
>>>
>>> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
>>> ---
>>> v1 -> v2:
>>>     - Separated the patches to dmaengine and spi subsystems
>>>     - Removed the changes which are not required for this feature from
>>>       qcom-gpi-dma.h file.
>>>     - Removed the type conversions used in gpi_create_spi_tre.
>>>
>>>   drivers/dma/qcom/gpi.c           | 32 +++++++++++++++++++++++++++-----
>>>   include/linux/dma/qcom-gpi-dma.h |  6 ++++++
>>>   2 files changed, 33 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
>>> index 52a7c8f2498f..4c5df696ddd8 100644
>>> --- a/drivers/dma/qcom/gpi.c
>>> +++ b/drivers/dma/qcom/gpi.c
>>> @@ -27,6 +27,7 @@
>>>   #define TRE_FLAGS_IEOT        BIT(9)
>>>   #define TRE_FLAGS_BEI        BIT(10)
>>>   #define TRE_FLAGS_LINK        BIT(11)
>>> +#define TRE_FLAGS_IMMEDIATE_DMA    BIT(16)
>>>   #define TRE_FLAGS_TYPE        GENMASK(23, 16)
>>>   /* SPI CONFIG0 WD0 */
>>> @@ -64,6 +65,7 @@
>>>   /* DMA TRE */
>>>   #define TRE_DMA_LEN        GENMASK(23, 0)
>>> +#define TRE_DMA_IMMEDIATE_LEN    GENMASK(3, 0)
>>>   /* Register offsets from gpi-top */
>>>   #define GPII_n_CH_k_CNTXT_0_OFFS(n, k)    (0x20000 + (0x4000 * (n)) 
>>> + (0x80 * (k)))
>>> @@ -1711,6 +1713,8 @@ static int gpi_create_spi_tre(struct gchan 
>>> *chan, struct gpi_desc *desc,
>>>       dma_addr_t address;
>>>       struct gpi_tre *tre;
>>>       unsigned int i;
>>> +    u8 *buf;
>>> +    int len = 0;
>>
>> First use of "len" is an assignment, so you shouldn't zero-initialize it
>> here.
> Sure, will do it in V3.
>>
>>>       /* first create config tre if applicable */
>>>       if (direction == DMA_MEM_TO_DEV && spi->set_config) {
>>> @@ -1763,14 +1767,32 @@ static int gpi_create_spi_tre(struct gchan 
>>> *chan, struct gpi_desc *desc,
>>>       tre_idx++;
>>>       address = sg_dma_address(sgl);
>>> -    tre->dword[0] = lower_32_bits(address);
>>> -    tre->dword[1] = upper_32_bits(address);
>>> +    len = sg_dma_len(sgl);
>>> -    tre->dword[2] = u32_encode_bits(sg_dma_len(sgl), TRE_DMA_LEN);
>>> +    /* Support Immediate dma for write transfers for data length up 
>>> to 8 bytes */
>>
>> And what happens if the developer writing the SPI driver forgets to read
>> this comment and sets QCOM_GPI_IMMEDIATE_DMA for a 9 byte transfer?
> In V2 patch, QCOM_GPI_IMMEDIATE_DMA is set based on 
> QCOM_GPI_IMMEDIATE_DMA_LEN only.
> 
> As per Hardware programming guide, immediate dma support is for up to 8 
> bytes only.
> Need to check what is the behavior if we want to handle 9 bytes using 
> immediate dma feature support.
> 
>>
>>> +    if ((spi->flags & QCOM_GPI_IMMEDIATE_DMA) && direction == 
>>> DMA_MEM_TO_DEV) {
>>
>> Why is this flag introduced?
>>
>> If I understand the next patch, all DMA_MEM_TO_DEV transfers of <=
>> QCOM_GPI_IMMEDIATE_DMA_LEN can use the immediate mode, so why not move
>> the condition here?
>>
>> Also ordering[1].
>>
>>     if (direction == DMA_MEM_TO_DEV && len <= 2 * sizeof(tre->dword[0]))
>>
>>
> Sure, thanks for the suggestion.
> so, instead using "QCOM_GPI_IMMEDIATE_DMA_LEN" need to use " 2 * 
> sizeof(tre->dword[0])" for 8 bytes length check.
> 
>> [1] Compare "all transfers of length 8 or less, which are mem to device"
>> vs "all transfers which are mem to device, with a length of 8 or less".
>> The bigger "selection criteria" is the direction, then that's fine tuned
>> by the length query.
>>
>>> +        buf = sg_virt(sgl);
>>
>> It's a question of style, but I think you could just put the sg_virt()
>> directly in the memcpy() call and avoid the extra variable.
> 
> Okay, i will directly put sg_virt() in memcpy().
>>
>>> -    tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
>>> -    if (direction == DMA_MEM_TO_DEV)
>>> +        /* memcpy may not always be length of 8, hence pre-fill both 
>>> dword's with 0 */
>>
>> The implementation of memcpy() is always more than 8 bytes, it's buf
>> that might be less than 8 bytes ;)
>>
>> Also you're not "pre-filling", you're "zero-initializing", or just
>> "initialize".
 >
Sure, will correct it to use initialize instead pre-fill.  i will update 
it in V3.
 >
>>
>>
>> That said, does it matter? Will the QUP read beyond the
>> TRE_DMA_IMMEDIATE_LEN bytes? If so, please put _that_ in the comment
>> ("QUP reads beyond the provided len, so additional content needs to be
>> cleared", or similar)
 >
Data lengths upto 8 bytes(len <=8) can be handled using immediate dma.
QUP won't handle beyond 8 bytes in immediate dma, if more than 8 bytes 
then it process using the logic mentioned in else path.

Each dword is of size 4 bytes and so in this immediate dma case, dword0 
and dword1 is used to hold 8 bytes data.In scenarios like data size 
lesss then 8 bytes, for example if the spi data transfer size is 4bytes 
then 4 bytes data will be updated into dword0 and dword1 might contain 
some garbage data and so make sure to initialize both dword0 and dword1 
with 0 and then memcpy the actual spi transfer data based on the length 
to the dword's.

> 
>>
>>> +        tre->dword[0] = 0;
>>> +        tre->dword[1] = 0;
>>> +        memcpy(&tre->dword[0], buf, len);
>>> +
>>> +        tre->dword[2] = u32_encode_bits(len, TRE_DMA_IMMEDIATE_LEN);
>>
>> Does the format of tre->dword[2] really change when
>> TRE_FLAGS_IMMEDIATE_DMA is set, or is TRE_DMA_IMMEDIATE_LEN just a
>> mask to highlight that len can't be more than 4 bits?
>>
>> It seems like you could drop TRE_DMA_IMMEDIATE_LEN and just use
>> TRE_DMA_LEN here? (But it should match what the hardware programming
>> guide states)
> As per hardware programming guide, for Immediate dma, in dword2 length 
> should be 4 bytes only and so need to use TRE_DMA_IMMEDIATE_LEN .
>>
>>
>> Perhaps you could reduce the scope of this if/else then as well, as the
>> assignment of of dword[2] and dword[3] is mostly the same with and
>> without immediate mode (just the one bit to enable it)
> sure, will check it and update in V3.
>>
>>> +
>>> +        tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
>>>           tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
>>> +        tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IMMEDIATE_DMA);
>>> +    } else {
>>> +        tre->dword[0] = lower_32_bits(address);
>>> +        tre->dword[1] = upper_32_bits(address);
>>> +
>>> +        tre->dword[2] = u32_encode_bits(len, TRE_DMA_LEN);
>>> +
>>> +        tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
>>> +        if (direction == DMA_MEM_TO_DEV)
>>> +            tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
>>> +    }
>>>       for (i = 0; i < tre_idx; i++)
>>>           dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
>>> diff --git a/include/linux/dma/qcom-gpi-dma.h 
>>> b/include/linux/dma/qcom-gpi-dma.h
>>> index 6680dd1a43c6..84598848d53a 100644
>>> --- a/include/linux/dma/qcom-gpi-dma.h
>>> +++ b/include/linux/dma/qcom-gpi-dma.h
>>> @@ -15,6 +15,10 @@ enum spi_transfer_cmd {
>>>       SPI_DUPLEX,
>>>   };
>>> +#define QCOM_GPI_IMMEDIATE_DMA        BIT(1)
>>> +
>>> +#define QCOM_GPI_IMMEDIATE_DMA_LEN    8
>>> +
>>>   /**
>>>    * struct gpi_spi_config - spi config for peripheral
>>>    *
>>> @@ -30,6 +34,7 @@ enum spi_transfer_cmd {
>>>    * @cs: chip select toggle
>>>    * @set_config: set peripheral config
>>>    * @rx_len: receive length for buffer
>>> + * @flags: true for immediate dma support
>>
>> Per above I think you can remove this flag, but "true for immediate DMA
>> support" doesn't match what you have written in the code. (Also in
>> general u8 shouldn't be "true")
> 
> Sure, will update in V3.
> 
> Thanks for providing the review comments.
>>
>> Regards,
>> Bjorn
>>
>>>    */
>>>   struct gpi_spi_config {
>>>       u8 set_config;
>>> @@ -44,6 +49,7 @@ struct gpi_spi_config {
>>>       u32 clk_src;
>>>       enum spi_transfer_cmd cmd;
>>>       u32 rx_len;
>>> +    u8 flags;
>>>   };
>>>   enum i2c_op {
>>> -- 
>>> 2.17.1
>>>
>>>
> 

