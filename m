Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF4F24C6FA
	for <lists+linux-spi@lfdr.de>; Thu, 20 Aug 2020 23:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgHTVGU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Aug 2020 17:06:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726716AbgHTVGS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Aug 2020 17:06:18 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07KL3F9P132149;
        Thu, 20 Aug 2020 17:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+wFKt5gOp2qKwt78X+GCUmMn4fQpqMO/fSREOF3d7cI=;
 b=eTm5DueWgcdzE/MxP/QLZbDxQdAHm6yNArQ/Ahc3YFmHdwRCy89fP6fkDvuSdjRmTauH
 8S9VIJG0EwtyXJ77raWjJ0WT/EKCvAidSdSt+M0Ro5KTq2uPi52tA2tyDAQmF4CM0s8J
 YE1PRJbYmA46O5MJL09QWAN8CXv0+6/7d/xMKkZiCiHHmWjSyc3XFtwdD1zIE0N0eDMd
 6AAFY1KKZi5EVbUll5G3Il42/yCetNYECWmjFWfUMerANjRLc74bOOgjUXAgUd4N3zrf
 DBxRc/1Cipd3VeQsu58gXwOhm5cuZ3mWTpa7ewlx+60ayrMKe1bavQ2jW1tZAT8u7qjy zA== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 331w97wwch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 17:06:10 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07KL4aZR010256;
        Thu, 20 Aug 2020 21:06:09 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma05wdc.us.ibm.com with ESMTP id 3304th737g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 21:06:09 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07KL68sb61145526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Aug 2020 21:06:08 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 612B7C6063;
        Thu, 20 Aug 2020 21:06:08 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01ACCC605D;
        Thu, 20 Aug 2020 21:06:07 +0000 (GMT)
Received: from [9.163.70.74] (unknown [9.163.70.74])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 20 Aug 2020 21:06:07 +0000 (GMT)
Subject: Re: [PATCH 2/7] spi: fsi: Fix clock running too fast
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, joel@jms.id.au,
        bradleyb@fuzziesquirrel.com, robh+dt@kernel.org, arnd@arndb.de
References: <20200820170228.42053-1-eajames@linux.ibm.com>
 <20200820170228.42053-3-eajames@linux.ibm.com>
 <20200820171257.GG5854@sirena.org.uk>
From:   Eddie James <eajames@linux.ibm.com>
Message-ID: <660034d2-c808-3a4b-6ecc-be1769e8a017@linux.ibm.com>
Date:   Thu, 20 Aug 2020 16:06:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820171257.GG5854@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-20_07:2020-08-19,2020-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 mlxlogscore=813 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008200170
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 8/20/20 12:12 PM, Mark Brown wrote:
> On Thu, Aug 20, 2020 at 12:02:23PM -0500, Eddie James wrote:
>> From: Brad Bishop <bradleyb@fuzziesquirrel.com>
>>
>> Use a clock divider tuned to a 200MHz FSI clock.  Use of the previous
>> divider at 200MHz results in corrupt data from endpoint devices. Ideally
>> the clock divider would be calculated from the FSI clock, but that
>> would require some significant work on the FSI driver.
> Presumably this divider was chosen for FSI clocks that aren't 200MHz -
> how will those be handled?


They aren't handled at the moment, but 200MHz FSI represents the worst 
case, as it's the maximum. Slower FSI clocks will simply result in 
slower SPI clocks.

Thanks,

Eddie


