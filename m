Return-Path: <linux-spi+bounces-6147-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 745999FAB30
	for <lists+linux-spi@lfdr.de>; Mon, 23 Dec 2024 08:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B66518854D2
	for <lists+linux-spi@lfdr.de>; Mon, 23 Dec 2024 07:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09991185B4C;
	Mon, 23 Dec 2024 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="POdQVv3L"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404B628E3F;
	Mon, 23 Dec 2024 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734939300; cv=none; b=kemnjXtwNqxmIHPXvRA4KpWbmdiZWFop5QRJ0NNu6fBGyxRfAF5M+5Nm2sIIdUlPyo2HM3Oh7AC/DQ2PBqg57lmL3K3LtmhDdB24sp1WVIpg//OQwXwtBHvU8VCU/W4L5REjCoMO83FxYE6FdKWhZXQ3KxHU4h4hQRtPW1EQE1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734939300; c=relaxed/simple;
	bh=VryaE6XKxfDURFPzkwEYqDUYI+vn+f7BOPHZAXh2PM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fZDvuVIM0Psp8m1dpDDa32exQhSN2Vn3SkiXyrxMsDLiZo1AKXNGF3+i+duetgMYt3yjlOCFC5d7/ZNGLs+XhSm7BzYwA7Z9fWYbsFSBrq/sMImvN4xFNnfin8yF4jGJwi+uaH091kfL5VhfIbhOsE9t61z0MM5JG8lB2S1HG44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=POdQVv3L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN3CTcH007799;
	Mon, 23 Dec 2024 07:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qSKJM6ybCMVZT3PW6LGJIGxVlrDYwONHfb1PGWrGQVE=; b=POdQVv3Ll8pTK6EW
	gWTsvWOMMoXSnexBBnURezDHRKgPfxc+SEJ+Pt/YpNOayata2I+9FZvtAnxZhOJn
	dHrXNiYcBX5hUQO48IDLqGnSk5I+QCcNieXd8apA1Is6+W8ADGnYdbfnVNDjFLST
	SU5D4f7bwV+JbQx5tIyyB+vqosflsCFM1aQjMRmw83A83RvJoGkFl7TGyWJ0XAxV
	QsiwJsA3ONDroJg9LMAC9yuX6SAmti8GCk9sExDIZNSptHe21mlMgHQjlj0N9T60
	WcLB7WCCsA8S6O7HbRfmhR21F8ECCzIGCQGwx/O4SpsDJWf17LGS/zD1BA8yIsPS
	nG+Mfg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43pyrprwqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 07:34:50 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BN7Yo2d002511
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 07:34:50 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 22 Dec
 2024 23:34:47 -0800
Message-ID: <9442d3c7-ba72-44ee-8370-6a7bd53c2ac7@quicinc.com>
Date: Mon, 23 Dec 2024 15:34:45 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] virtio-spi: Add virtio SPI driver.
To: Qiang Zhang <qiang4.zhang@linux.intel.com>,
        Harald Mommer
	<Harald.Mommer@opensynergy.com>
CC: <virtio-dev@lists.oasis-open.org>, Mark Brown <broonie@kernel.org>,
        "Viresh Kumar" <viresh.kumar@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ztu@quicinc.com>,
        Matti Moell
	<Matti.Moell@opensynergy.com>,
        Mikhail Golubev
	<Mikhail.Golubev@opensynergy.com>
References: <20240326112812.31739-1-Harald.Mommer@opensynergy.com>
 <20240326112812.31739-4-Harald.Mommer@opensynergy.com>
 <Zt7xEzOaanKiXLbq@dev-qz>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <Zt7xEzOaanKiXLbq@dev-qz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BHIvnzopceHdmWHBeNPn4XhDYJcq3FNF
X-Proofpoint-GUID: BHIvnzopceHdmWHBeNPn4XhDYJcq3FNF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230066

Hi @Qiang Zhang,

     Thank you for your comments, and please refer to my response below. 
I would co-work with Harald on this driver.

On 9/9/2024 8:59 PM, Qiang Zhang wrote:
> Hi, Harald
> 
> On Tue, Mar 26, 2024 at 12:28:12PM +0100, Harald Mommer wrote:
>> From: Harald Mommer <harald.mommer@opensynergy.com>
>>
>> This is the virtio SPI Linux kernel driver.
>>
>> Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
> [...]
>> +static int virtio_spi_probe(struct virtio_device *vdev)
>> +{
>> +	struct device_node *np = vdev->dev.parent->of_node;
>> +	struct virtio_spi_priv *priv;
>> +	struct spi_controller *ctrl;
>> +	int err;
>> +	u32 bus_num;
>> +	u16 csi;
>> +
>> +	ctrl = devm_spi_alloc_host(&vdev->dev, sizeof(*priv));
>> +	if (!ctrl)
>> +		return -ENOMEM;
>> +
>> +	priv = spi_controller_get_devdata(ctrl);
>> +	priv->vdev = vdev;
>> +	vdev->priv = priv;
>> +	ctrl->dev.of_node = vdev->dev.of_node;
> 
> To support ACPI, ACPI node of the controller needs to be set:
> 
> 	/*
> 	 * Setup ACPI node for controlled devices which will be probed through
> 	 * ACPI.
> 	 */
> 	ACPI_COMPANION_SET(&vdev->dev, ACPI_COMPANION(vdev->dev.parent));
> 

Yes, will add in next patch.

>> +	dev_set_drvdata(&vdev->dev, ctrl);
>> +
>> +	init_completion(&priv->spi_req.completion);
>> +
>> +	err = of_property_read_u32(np, "spi,bus-num", &bus_num);
>> +	if (!err && bus_num <= S16_MAX)
>> +		ctrl->bus_num = (s16)bus_num;
> 
> This is not the right way to fix bus number. You can use OF alias.
> Also, to work with ACPI, we should use common API like
> device_property_read_u32.
> 

I agree with you, "spi,bus-num" should not be mandatory in the device tree.

How about updating as follows:

+	err = device_property_read_u32(ctrl->dev, "spi,bus-num", &bus_num);
+	if (!err && bus_num <= S16_MAX)
+		ctrl->bus_num = (s16)bus_num;
+	else
+		ctrl->bus_num = -1;

So if "spi,bus-num" not set, bus_num is initialized as -1, then in 
function spi_register_controller, bus_num will be reassigned by OF 
alias(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi.c?h=v6.13-rc4#n3287), 
or dynamic 
allocated(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi.c?h=v6.13-rc4#n3295). 


>> +
>> +	virtio_spi_read_config(vdev);
>> +
>> +	ctrl->transfer_one = virtio_spi_transfer_one;
>> +
>> +	err = virtio_spi_find_vqs(priv);
>> +	if (err) {
>> +		dev_err(&vdev->dev, "Cannot setup virtqueues\n");
>> +		return err;
>> +	}
>> +
>> +	board_info.max_speed_hz = priv->max_freq_hz;
>> +	board_info.bus_num = (u16)ctrl->bus_num;
>> +
>> +	if (!(priv->mode_func_supported & VIRTIO_SPI_CS_HIGH))
>> +		board_info.mode = SPI_MODE_0;
>> +	else
>> +		board_info.mode = SPI_MODE_0 | SPI_CS_HIGH;
>> +
>> +	err = spi_register_controller(ctrl);
>> +	if (err) {
>> +		dev_err(&vdev->dev, "Cannot register controller\n");
>> +		goto err_return;
>> +	}
>> +
>> +	if (vdev->dev.of_node) {
>> +		dev_dbg(&vdev->dev, "Final setup triggered by DT child node\n");
>> +		return 0;
>> +	}
> How about ACPI path?
>> +
>> +	/* Add chip selects to controller */
>> +	for (csi = 0; csi < ctrl->num_chipselect; csi++) {
>> +		dev_dbg(&vdev->dev, "Setting up CS=%u\n", csi);
>> +		board_info.chip_select = csi;
>> +
>> +		if (!spi_new_device(ctrl, &board_info)) {
>> +			dev_err(&vdev->dev, "Cannot setup device %u\n", csi);
>> +			spi_unregister_controller(ctrl);
>> +			err = -ENODEV;
>> +			goto err_return;
>> +		}
>> +	}
> Just enumerate SPI devices via DT/ACPI. And a fixed SPI modalias "spi-virtio"
> is no better than match method from DT/ACPI.

How about deleting the following code.

+	if (vdev->dev.of_node) {
+		dev_dbg(&vdev->dev, "Final setup triggered by DT child node\n");
+		return 0;
+	}

+	/* Add chip selects to controller */
+	for (csi = 0; csi < ctrl->num_chipselect; csi++) {
+		dev_dbg(&vdev->dev, "Setting up CS=%u\n", csi);
+		board_info.chip_select = csi;
+
+		if (!spi_new_device(ctrl, &board_info)) {
+			dev_err(&vdev->dev, "Cannot setup device %u\n", csi);
+			spi_unregister_controller(ctrl);
+			err = -ENODEV;
+			goto err_return;
+		}
+	}

Then we can use the ACPI implementation in 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi.c?h=v6.13-rc4#n3378.

Also creating SPI devices statically based on the board info seems 
somewhat unreasonable. I agree that DT/ACPI are the only reasonable way 
to specify the SPI nodes.


Thanks again
Haixu Cui

> 
> Thanks,
> Qiang


