Return-Path: <linux-spi+bounces-9656-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5AFB33A11
	for <lists+linux-spi@lfdr.de>; Mon, 25 Aug 2025 11:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20E7C7A1020
	for <lists+linux-spi@lfdr.de>; Mon, 25 Aug 2025 09:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840712417E6;
	Mon, 25 Aug 2025 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eo2k90+i"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA05A20013A;
	Mon, 25 Aug 2025 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756112528; cv=none; b=oBM3bM5X9MxxGIpVNkdJZwiE7J89iJLZTrZ6K5KV9sngyHNGdovK99kn/JCM4iAPdMrdNXFG14OLWQPYqqoRZzeB/vK/6DxPigVwdThWBSuZjZIk11Fxf6BmU2nRnZ1K+q/dhx6osoTmj6hWWNHE9ZWiBvGlaoISUk9i1cBWcBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756112528; c=relaxed/simple;
	bh=olJ5OfYe5gD3pVafV9J8crtGdqB1Wwgk5wAkeQKHr1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HyNchpSi7aM9b01NIhXfbF3K/ZxGp0Cgc9SjUyiw2VleQh2T0VSg+oe0MzrwVLGKRlPTmkENoNy9O2GJGtYWWwb4JhpQzCgbV7opBlTLInlcrtldrG6JmGEjhx/GmNmczm+O4XzvU5JIqdqNWnNoeullyFPSWgij/7jgCdiHRjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eo2k90+i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8VgxV022786;
	Mon, 25 Aug 2025 09:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sI1VaHbnI86/2Tk5Uu2onSdA+XK1tUyznWlaN1sEpeE=; b=eo2k90+iCq9Ao+7E
	bkwXp8RGmIJabyx3AnSjSgj2f4jusgZjIXDayTXtWWHCqyx25/O5vBBGGv2aEola
	jNeho7fP0UTANSNKSPQ/LrMHwyR35WkjB+laTJDtYScvZWTAy5Iv8Bw8U8rRTXUY
	FbsKfA2Lere1RStEqc+n39DAj0/7JrT1nsJNMi8RgwoV25+7tmsTNDxL9Y+Pxtpw
	fB+9yX+CQ6MmVuPAXVXv9sPTNHJ9M00ZupOQMD3a5ope9mLOEX2vriCQo+o4AxWY
	3wFO4Tf1G20auAXSrw2YsfHsuax+rrVl46xKvUNqmr4LrSRNFr4zFec73plyOUT6
	k1Jf4Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unmexx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 09:01:48 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57P91k2p011018
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 09:01:46 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Mon, 25 Aug
 2025 02:01:44 -0700
Message-ID: <f2eefbeb-9a97-41db-a2e5-f069a8319900@quicinc.com>
Date: Mon, 25 Aug 2025 17:01:41 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] SPI: Add virtio SPI driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: <harald.mommer@oss.qualcomm.com>, <quic_msavaliy@quicinc.com>,
        <broonie@kernel.org>, <virtio-dev@lists.linux.dev>,
        <viresh.kumar@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hdanton@sina.com>,
        <qiang4.zhang@linux.intel.com>, <alex.bennee@linaro.org>,
        <quic_ztu@quicinc.com>
References: <20250820084944.84505-1-quic_haixcui@quicinc.com>
 <20250820084944.84505-4-quic_haixcui@quicinc.com>
 <aKXePVShWzXGi8yP@smile.fi.intel.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <aKXePVShWzXGi8yP@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AdpXP-3w3b2lzjoM9Ok25xKHYWCPxGMg
X-Proofpoint-ORIG-GUID: AdpXP-3w3b2lzjoM9Ok25xKHYWCPxGMg
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68ac267c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=SzxDVUQ6BuH0VNSqFgwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfXxeyGIwKejTtD
 TSNB8eclWcFw4RMwYy8b8QwfBHd+RSoScHzcKzNhQzQ5UEWFs124OUf4L0rnuntqJJZMoYUK/xA
 9Q7NPt69PKzzf4FYTLX2dmfmbwTWobdv2Hg0xWVE+gy7ueMQQduZ1qRnNG488B/cN5cg2tgEghh
 JsfvxUlrR4x3KX5xGsUO5BjkMqSJyNDfI24CDdqsc7NUNmlheTnyEdBo3H8AavXtUYC17pyJrQi
 Iv/B0wVEdmG/j1TNPb4+9/3OvbdJlowHaRsn4sswRUWSBDoJHZku1taZzPO0E16YMCk7uqsUvPw
 jGDWT5Bbk9LfcLlnCRWnLmNnE+SV/qeykw8VMhgGwmZo1DnYmwS8woYS5Xds6VDON4Oefz+ieqw
 vvef9Jma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

Hi Andy,

Thank you very much for your review and suggestions, I truly appreciate it!

I've carefully considered your comments and have replied directly under 
your comments with the corresponding changes. These updates will be 
included in next version of patch. Please let me know if there's 
anything else I should address.

Thanks again for your guidance and support.

Best Regards
Haixu Cui

On 8/20/2025 10:39 PM, Andy Shevchenko wrote:

> 
>> +#define VIRTIO_SPI_MODE_MASK \
>> +	(SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST)
> 
> We have SPI_MODE_X_MASK.
> 

#define VIRTIO_SPI_MODE_MASK \
         (SPI_MODE_X_MASK | SPI_CS_HIGH | SPI_LSB_FIRST)


>> +struct virtio_spi_req {
>> +	struct completion completion;
>> +	struct spi_transfer_head transfer_head	____cacheline_aligned;
>> +	const u8 *tx_buf;
>> +	u8 *rx_buf;
>> +	struct spi_transfer_result result	____cacheline_aligned;
>> +};
> 
> Dunno if `pahole` aware of ____cacheline_aligned attribute, but does it shows
> any potential improvement?
> 
> I think the fields can be reshuffled to go last and only one needs that
> attribute.
> 
> struct virtio_spi_req {
> 	struct completion completion;
> 	const u8 *tx_buf;
> 	u8 *rx_buf;
> 	struct spi_transfer_head transfer_head	____cacheline_aligned;
> 	struct spi_transfer_result result;
> };
> 
Ok, I’ll adjust the structure as recommended.



>> +static int virtio_spi_set_delays(struct spi_transfer_head *th,
>> +				 struct spi_device *spi,
>> +				 struct spi_transfer *xfer)
>> +{
>> +	int cs_setup;
>> +	int cs_word_delay_xfer;
>> +	int cs_word_delay_spi;
>> +	int delay;
>> +	int cs_hold;
>> +	int cs_inactive;
>> +	int cs_change_delay;
>> +
>> +	cs_setup = spi_delay_to_ns(&spi->cs_setup, xfer);
>> +	if (cs_setup < 0) {
> 
> Hmm... Not a problem in your code, but ns can be quite high for low speed
> links, there is a potential overflow...

You're right—ns values can be quite high on low-speed links, and there's 
a potential risk of overflow. I’ll keep a close eye on this and I've 
noted this as a follow-up action item.



> 
>> +	if (cs_word_delay_spi > cs_word_delay_xfer)
>> +		th->word_delay_ns = cpu_to_le32(cs_word_delay_spi);
>> +	else
>> +		th->word_delay_ns = cpu_to_le32(cs_word_delay_xfer);
> 
> Why not max() ?

update code with max() using:
th->word_delay_ns = cpu_to_le32(max(cs_word_delay_spi, cs_word_delay_xfer));



>> +	unsigned int outcnt = 0u;
>> +	unsigned int incnt = 0u;
> 
> Are 'u':s important in this case/

Will remove 'u' here.


>> +msg_done:
> 
>> +	kfree(spi_req);
> 
> Can be called via __free() to simplify the error handling,
> 

Yes, will update spi_req definition as follows then remove 
kfree(spi_req) here:

struct virtio_spi_req *spi_req __free(kfree);



>> +static int virtio_spi_probe(struct virtio_device *vdev)
>> +{
>> +	struct virtio_spi_priv *priv;
>> +	struct spi_controller *ctrl;
> 
>> +	int err;
> 
> Out of a sudden it's named 'err'. Please, go through the code and make
> style/naming/etc consistent.
> 
I'll update the naming to consistently use ret throughout, replacing err 
and other variants where appropriate



>> +	device_set_node(&ctrl->dev, dev_fwnode(&vdev->dev));
> 
>> +	/* Setup ACPI node for controlled devices which will be probed through ACPI. */
>> +	ACPI_COMPANION_SET(&vdev->dev, ACPI_COMPANION(vdev->dev.parent));
> 
> This is strange. Either you need to put parent above in device_set_node() or
> drop it here. Otherwise it's inconsistent. Needs a very good explanation what's
> going on here...

I'll remove the ACPI_COMPANION_SET() line and kept only 
device_set_node(&ctrl->dev, dev_fwnode(&vdev->dev)); to ensure consistency.

> 
>> +	dev_set_drvdata(&vdev->dev, ctrl);
>> +
>> +	err = device_property_read_u32(&vdev->dev, "spi,bus-num", &bus_num);
>> +	if (!err && bus_num <= S16_MAX)
> 
> This is wrong. What is the bus_num value when err != 0?
> And why do we even care about this?
> 
>> +		ctrl->bus_num = bus_num;
>> +	else
>> +		ctrl->bus_num = -1;
>> +

Update as follows:
ret = device_property_read_u32(&vdev->dev, "spi,bus-num", &bus_num);
         if (ret || bus_num > S16_MAX)
                 ctrl->bus_num = -1;
         else
                 ctrl->bus_num = bus_num;



>> +	err = virtio_spi_find_vqs(priv);
>> +	if (err) {
> 
>> +		dev_err_probe(&vdev->dev, err, "Cannot setup virtqueues\n");
>> +		return err;
> 
> 		return dev_err_probe(...);
> 
Acknowledged.




>> +	/* Register cleanup for virtqueues using devm */
>> +	err = devm_add_action_or_reset(&vdev->dev, (void (*)(void *))virtio_spi_del_vq, vdev);
>> +	if (err) {
>> +		dev_err_probe(&vdev->dev, err, "Cannot register virtqueue cleanup\n");
>> +		return err;
>> +	}
>> +
>> +	/* Use devm version to register controller */
>> +	err = devm_spi_register_controller(&vdev->dev, ctrl);
>> +	if (err) {
>> +		dev_err_probe(&vdev->dev, err, "Cannot register controller\n");
>> +		return err;
> 
> As per above.
Acknowledged

> 
>> +static int virtio_spi_freeze(struct device *dev)
>> +{
>> +	struct spi_controller *ctrl = dev_get_drvdata(dev);
>> +	struct virtio_device *vdev = container_of(dev, struct virtio_device, dev);
> 
> Use dev_to_virtio()
Acknowledged




>> +static int virtio_spi_restore(struct device *dev)
>> +{
>> +	struct spi_controller *ctrl = dev_get_drvdata(dev);
>> +	struct virtio_device *vdev = container_of(dev, struct virtio_device, dev);
> 
> As per above.
Acknowledged

