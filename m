Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DC624C700
	for <lists+linux-spi@lfdr.de>; Thu, 20 Aug 2020 23:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHTVHw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Aug 2020 17:07:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48000 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726854AbgHTVHv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Aug 2020 17:07:51 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07KL6muY076923;
        Thu, 20 Aug 2020 17:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cNPydKepE6JGZ2gi/JZvKIkzQLLKoYhIjxEY34n3Hrw=;
 b=Fcz7mZN/K299CuV9hss1RPft0Af543u7z/mVz1zmJtGcr8lOpLo8kCjALnxqptDV3vNp
 UlgABjT4jjhxhW7sbGBFvkDbu8ilCaOs0m2923BMmM1XBrrl1pYV4k8FC5adXJinUDmQ
 5FTn85ilU6ham9h68IiiFa+M5aTa7zhsUF3VBdfAjivhwi9ufI8wLlgaPXnb4rsyLsVB
 uHSEAPXA/2/PVZqI1elHJmBdjhnB89lQZlLADuCZYE052TKlC7PQ/hu2LkvM+gEMSOlG
 wW8o24leLm3LfaZsS9lFigU2LszhAXze1WNTQUMLkILZwG4pEZ240KqO+tBUIMTjkYov 0A== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3314mx2hej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 17:07:44 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07KL6IgC023472;
        Thu, 20 Aug 2020 21:07:43 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02wdc.us.ibm.com with ESMTP id 3304sd75p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 21:07:43 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07KL7cwE61604256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Aug 2020 21:07:38 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C4F3C605B;
        Thu, 20 Aug 2020 21:07:42 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A3CAC605A;
        Thu, 20 Aug 2020 21:07:42 +0000 (GMT)
Received: from [9.163.70.74] (unknown [9.163.70.74])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 20 Aug 2020 21:07:41 +0000 (GMT)
Subject: Re: [PATCH 4/7] dt-bindings: fsi: fsi2spi: Document new restricted
 property
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, joel@jms.id.au,
        bradleyb@fuzziesquirrel.com, robh+dt@kernel.org, arnd@arndb.de
References: <20200820170228.42053-1-eajames@linux.ibm.com>
 <20200820170228.42053-5-eajames@linux.ibm.com>
 <20200820171430.GH5854@sirena.org.uk>
From:   Eddie James <eajames@linux.ibm.com>
Message-ID: <b9fbd669-3573-a0c9-18d8-6c0c7926625a@linux.ibm.com>
Date:   Thu, 20 Aug 2020 16:07:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820171430.GH5854@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-20_07:2020-08-19,2020-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=786 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008200170
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 8/20/20 12:14 PM, Mark Brown wrote:
> On Thu, Aug 20, 2020 at 12:02:25PM -0500, Eddie James wrote:
>> Add documentation for the "fsi2spi,restricted" property which indicates
>> a controller shouldn't sequence loops and therefore has a smaller
>> transfer size.
> In what situation might someone set this?  It sounds like a
> configuration option rather than a description of the hardware.


It is a description of the configuration of the hardware. For 
controllers that are configured to be restricted for security purposes, 
this property will be set.

Thanks,

Eddie


