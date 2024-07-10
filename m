Return-Path: <linux-spi+bounces-3825-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F6992D054
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jul 2024 13:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5721F22075
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jul 2024 11:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039C818FC90;
	Wed, 10 Jul 2024 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yFFNdbFe"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E549018FA32;
	Wed, 10 Jul 2024 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720609962; cv=fail; b=IF7C2cr/jEf4890KCdhaJ3vXegnGnTQUsBl8KKGjmgUjiZLmbFGIIFe7NKyGPViTAECvLj6kd4Fkbo4ExerQHr1W0MmypJQQgZflvt+EPm+7K9ZUdda2cIVOemTyRkRVawFiCwtqt+7VCVE169rX015FmymfnXsw8L9VQusWOZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720609962; c=relaxed/simple;
	bh=mWD0UT+GGdkfwl10LgBcfgYHaxnTgyc61WZZkdp7vFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rLAe/qSvnZguF6scCf2qjg7ayKj5vc9d/F8tQboGP/2AjVx9GyHe82l3e/FEiwhaEnvvMFxmMWTb069OmnQXyMZXB43oc3YA8FTN+THfsoMiUmlzLHvfjfOKzDXU2qMz7mexUODO8zdC5YZHcg8ycw8pDVEUSymKR9VqlUVEST0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yFFNdbFe; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFMtNLcIpsMFo7LS3wy5LHpabVKsW4l6iUUolLCSJ31oYc1476D9ZD7Y4Hp+GzqLH3i9md8BQSdYikteA8hfFORjWQWJhr2QqoIOo6+TnmW+Qu72T9ZPjbraz54WuJVr5YMkSUik942ThFlmVzGO0gnITJkSAT7FQ/JCWUSeoANZnZiYi6kA2FnQe5a4aBRkvbB50LOm6XmEGsBz1mIPTlP5XyS9Zc351/54JFRyZXOxuYrmMSwgE3bRbS8DVnXlPh3HeqQUGTmlEZrkWZaIcASTJeHPpMiZv4f3UyH2fY8pfLk786oa26z8WaptTXdtwvXjMVm/ZSi0I2TezukK9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWD0UT+GGdkfwl10LgBcfgYHaxnTgyc61WZZkdp7vFg=;
 b=AT6DrOfsH94vph7yTyW4o7Ulquku1sDGzAymIxp6FY8zdpNLD0ujaLNdQw9XerILEyBCeopQLtc1bqWncR6RlalHW8Jmx0vEFdglFuP4LdB4spRamBXezQA94r70lZDZwIf9FUN/qDkV64Ruvhlu4JSVG8NUHGIFey6PiBiA3Ms5FvZNynmtKbEVYXBTPFGfVyOQ/A3H8N4HpJMb2WcUfy6XEDUERGlw+vtfiabGZWdLFC9EffS1D54iZ9ueZFmCWkremO4IgORtUTmi5KSfcxHX4ZmNUCQsNgfGdGhQJuCSbe9Yxkk819PqV6DquzjnYilDXnBq/n2/3AiUSp/h/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWD0UT+GGdkfwl10LgBcfgYHaxnTgyc61WZZkdp7vFg=;
 b=yFFNdbFeY+83iR8+D5QIkZ/3stMOcQR2z1tKUVQ8cICLliRYhmHSw7sYJ9fPwJTDS/Ua1G99ABw79zWwM5wfb+EV449orc9TLBnAwtMfglZKtvqkz5xg8U+IovwJ7iKCS9NzhxrQEBJaEzHp+CqZtKt6PU/XAV+/nDWcDsOuq7Y=
Received: from DM4PR12MB5231.namprd12.prod.outlook.com (2603:10b6:5:39b::19)
 by SJ0PR12MB6710.namprd12.prod.outlook.com (2603:10b6:a03:44c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 11:12:38 +0000
Received: from DM4PR12MB5231.namprd12.prod.outlook.com
 ([fe80::518d:e364:6eb1:3f10]) by DM4PR12MB5231.namprd12.prod.outlook.com
 ([fe80::518d:e364:6eb1:3f10%5]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 11:12:38 +0000
From: "Thangavel, Karthik" <karthik.thangavel@amd.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>
CC: "Gaddipati, Naveen" <naveen.gaddipati@amd.com>, "Narra, Bharath Kumar"
	<BharathKumar.Narra@amd.com>
Subject: RE: IMA Reports No TPM Device
Thread-Topic: IMA Reports No TPM Device
Thread-Index: Adq4qE45KxXVKDnZQr2Y5S02DshRfAIwHLiwAAULBAAETzDuIA==
Date: Wed, 10 Jul 2024 11:12:37 +0000
Message-ID:
 <DM4PR12MB52316451516FF73600BD6E40FFA42@DM4PR12MB5231.namprd12.prod.outlook.com>
References:
 <BN9PR12MB5228AB9BF8A3951983B39EBEFFFB2@BN9PR12MB5228.namprd12.prod.outlook.com>
	 <DM4PR12MB52310B4519DE2FF70420DA5EFFCE2@DM4PR12MB5231.namprd12.prod.outlook.com>
 <727c5fae6391525a03b12e369dc35633fdbefca7.camel@huaweicloud.com>
In-Reply-To: <727c5fae6391525a03b12e369dc35633fdbefca7.camel@huaweicloud.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5231:EE_|SJ0PR12MB6710:EE_
x-ms-office365-filtering-correlation-id: 700bcf1b-02e8-49f3-d24c-08dca0d13523
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OEhicWw1SFhEUE43L3JmSTlYU3ZHb0FrNVZEUnMyZ05vdTNYaERtMk8wejFj?=
 =?utf-8?B?SEp4SVJMM1dVdWhIeFlJbHQyZUdVTjlidXF5ZlpjZFFNL2tVRjg4eE84YVBK?=
 =?utf-8?B?bXBpekZVdS9FSnRadkFiM3VNTHRaaTEwSnpBc0JJTCtaN3doRVl0MHRQeEtz?=
 =?utf-8?B?enJSRExjT1RLa2taWnpoV0E1M1J4dTM2eDAvZ1VnaTlFNWc1eXFOZjNTYkZr?=
 =?utf-8?B?aHlHL3dJeG1kTEh4SExQQ1JsUGFZclM5dVRsbU4rWTREOHBhTDRNOE9QUVBm?=
 =?utf-8?B?aVptZURqcDNZWSswT3pUTUpTNVc2L005RXFSbzlWY1pMM1ludTdzUjJ1T2Nh?=
 =?utf-8?B?WUhrcm9zdGxjVHIxUzRuaCtLYVNKRGFwckFLTzVsdnZkSkpBemJlMmsvd3ZR?=
 =?utf-8?B?d1B6VkFWN3M2SWp1Z3ZDM080RGJzaERTWTAyaGhaQzZYT0xjQVo5VlB2RlF4?=
 =?utf-8?B?UlIrRGdhVXJiK2FWRGhMSEhSclFpcWdCdXc5bFk5Sm5udS83ZS9XRFZpRTZN?=
 =?utf-8?B?N3lSbS9ndDhQYllnaTZNOGtIQWtjOSt5YXd1U1Y1OGVLR1lNYXUzWis2VWIv?=
 =?utf-8?B?Z044R1JaWFlHVEJSZFpldVpCb0s0RUIyVFFpbGhQQVVNNkRxMnZWWVVtMzVD?=
 =?utf-8?B?cFgvbWZZTitQNUNCL2JzNTVVbWd1aUZvMGRyT25iQlg1S1ZtZWdhUVFMY2ox?=
 =?utf-8?B?V1c0MlYrdDA4UXA3SWhvSFJURWRrQVpCUFcrZWVSc1pkelEzdEpTelNNdGNy?=
 =?utf-8?B?Y25rUGtiOTQ0ZDIrMGFKRVNkR1lzQmJTTlF1SG42eEJLWDZJdUN5eWhLSWVu?=
 =?utf-8?B?NUliM2RLdlhOdnJYRWVaNnErNHpScHZSWTZOUGk4RURaTW5jSnVYeE1lVnZC?=
 =?utf-8?B?ZnJNMkJRVEhCWmNBcTd0MFpCOXl5ZjJsTGVOYUc3ZTd3T2tjZzlka2cvbFda?=
 =?utf-8?B?eHZqbjBOSVU2cXhyNlJwNURnOU4yRXAzaDhhYlJSY2pyaFV6VUtsbGRSbkNI?=
 =?utf-8?B?MXcyZzVNTEpLVnJTdGpkazhZeDB6dGFScWZZWlo2aXBndFN1QWNxK1FkWjdL?=
 =?utf-8?B?WlFvdFl0T1V0UERRWFBtbzJ0aDJ3U3N1UFZvVDZlWFRGTkV3RjVPdEZ0bmV6?=
 =?utf-8?B?N2VvbEZEejhNVDcxekxhbHcrSW9tUHV3RlpWVWNkb2NSVklCQmlKeEEyb094?=
 =?utf-8?B?T0dPaGdNbGZoTGUraXE3OVpKM091MnIvb2JiVlBhSjBXaVA2YWNVTUZQNlFt?=
 =?utf-8?B?akhYcWRMNkNDS1Vja2krOE40SUZOMk1McFdXWXk4S29IUFYwZTRHTWQyaU1k?=
 =?utf-8?B?eFBwdW5ON3B3RitjNm5GeWFkNnZxVG9SbzJaV0lJV21SYktMZWxDYnlsalFt?=
 =?utf-8?B?Z0daQjdPRTJmcUpnWEd5WmN0UDdvR2RYdmoxN3FDVDNwLzhHYlUzODkyWUIr?=
 =?utf-8?B?QXBZdTVjTXZ4NHA4MzR4d3h0NzN3ZjFCM05ZeWowNncwb1N1WE4ySE1oV3k4?=
 =?utf-8?B?di9TbE9yNXpFclptZzNROUlGU3FQb3gyRDFjbHJtVzBLNjYvMEl3di9IMm1s?=
 =?utf-8?B?SXRwSHhrYXEzSU9mRmhESnU0bkJkaTF0cGUwMGEzRm5DcjlHL1BQTi9veXNJ?=
 =?utf-8?B?dWZ0NHpxTW43THpwdFgwQW1IWjY2SG14b3pyc3QrYlAwem9sQVR1TG8zN2lU?=
 =?utf-8?B?TVI2K0lBSEJ0d01IWXdpRDJWZVVZelJxd1NsRE1pNUV6N0ZQTzRuU1ZrbHlZ?=
 =?utf-8?B?cVlSQ0o4NWtJZHBsbnVqSGtERWRLMzF4eFJVZHRhU29ZYVdlZUZRM3pMUlpK?=
 =?utf-8?Q?FsjPI5Lbro5CLiKNrsgQPgxFT9QEwcg38v+Jc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5231.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WCtDa0JyZExRV0Y2V1pUZEc5ZjBLZXZNbXk2c24ydHEvcytKL2d5L0d5RTFa?=
 =?utf-8?B?NHZ5WHFVYzVLZzd6ZWpUUFBpdnlOVUd1VXFXMHVvVWVETDMremxGbVpjS285?=
 =?utf-8?B?cTFsNTNmZ0lpTmMrcWR0T3ByQkU0SnNQcGNUSFVRdmFaNzFaMitKd2RBMzho?=
 =?utf-8?B?dG9aZ0gwRm9wN1BFN0QySGVpa3RRMkRGcklBbVF5VStlNklWanVQeDRBSUR1?=
 =?utf-8?B?L01JbXFoZmwvaUtDcTAvWkJNYi9IMElpak82MklXazBFVlg4QXRPUlJhd010?=
 =?utf-8?B?MExhK2FEOEdUcmpEcEJtTFM4MFB1Tk9QYnpSUmMrRzhWeTF3eU9GaU5jRStE?=
 =?utf-8?B?WS9iYXJTdFYwWjl5UkRJclJEOThNK0pzN3NjMGtVV0swVmhSUGk0MHFqdVRp?=
 =?utf-8?B?dytXYUVzZmtCeTFsWWxGVjBpUERQc0p4c256L3d5L08wQkVQNVBvMDlUS0xV?=
 =?utf-8?B?ZHpnUS9tTGw4Mjd3Rm9tOTB5VmQ2UnI5Z2tEVmZIa21jQXZCa0pyemMvMG9s?=
 =?utf-8?B?bGxVREdqdTEwRkFVNWtsU0lFZ1doRlM5bXFmWjJNbWliZ3Q3T2JvWXNpTEdp?=
 =?utf-8?B?NTBOcE9pdXBBM3A4VlZ3VWZoazhVSEg2M1NRNDBTQTdwK3dqT3F3ZUVxRU5t?=
 =?utf-8?B?cFFheFoySFlsRWl6YlEzQ05uNlo3TnBPU1ZFZmpxU3JkWDliS1VsV3ZXcGRx?=
 =?utf-8?B?UGo1YWptU3Y5YzVGWkQ0M1dVb0VQZURTYnFnZVF4d1NzR25CUEZnU0pwNlJy?=
 =?utf-8?B?UUQ3UzEvRHFjeEVFUlBkYmVIK2czenhpcGxJdnBnWlExYTlJYVlsTkYwRmth?=
 =?utf-8?B?MmV1cCtWTHZTUGVhUGpoUk1VN0UwNjF2NzBQTkJSbE45QmdFbkFoZ25hSmxZ?=
 =?utf-8?B?ZHdvdjBkZCtLS1pvL3B0QllhRThQOUxISkZWRm1idjNwMlN0OGliQ2tTd2Vl?=
 =?utf-8?B?Q1Y1amcrSFJOWFV3NmVoWnY0V1cwMC9SNTFyTXdDN051YXprYm5UYTlsTDQ1?=
 =?utf-8?B?dithUWx3dExZUXhlOGw0YVl3RTZ3NDNXcU5hTzI4L3hqMkxGZUJCK3JpRUh4?=
 =?utf-8?B?Y3RwdGtBeWVybWlWQXptY1hBOWt4N0wvQkZKV1pMSSs2bkE3RS9HWGlxSFdC?=
 =?utf-8?B?SmhhTHQ0L1pUUmw1VWQ4cnlha3hDNVZtU1l4RWxwdGpUUGxmc1N5VCt2YXFY?=
 =?utf-8?B?dld4V2poWG9aMWJyRHJrYlhvM0JyOVVWTWw3Mk1Md1F1S3JLZi9MaTZ1UTJQ?=
 =?utf-8?B?aW5Ed0U1TUNiUW00QmNjTHdjcW8yZjk5MFIxbUFKK1FIM0xGeEZ6eDdzUUto?=
 =?utf-8?B?N1BIU0xnM3hyOERIMTNCcW9aMWFDYkdta3VuREtOekpnREVpMGhOUldVY3Fz?=
 =?utf-8?B?WHd2OEtHbG5EMnBlSVhxTXZMRjRsM2ZyblU5OHpIejNpRTFJMjk1eFZvbm84?=
 =?utf-8?B?NmVEMlQwcFZUV2JzcWltQzAvMXkvbktQclZXbU9XeDdYSGFEL2JGU1RQWVJC?=
 =?utf-8?B?dWVuTGtFVFU4YVEzQ2FWWmJYa2Y3a2tCZGQ4V0lZLzZFZFBVRW9taFRpQTVj?=
 =?utf-8?B?ekhEaFdXaE9vM2V0Skwxbm9TL0NTZ0VsSTFYaENDcFMvTFRWdTArcVFOVk0v?=
 =?utf-8?B?aERWTC9PZjh5VVlVQzVYZXR4cnUxYk4xazZLVWdyV1Vza3JyWDFMQTBaazVJ?=
 =?utf-8?B?cjZiY1BMcWR2M2UxaG1HdExuVzlKbHpQQlJFZ2EvNXFsRnY3VmI4RUlVMHBC?=
 =?utf-8?B?SUpxdVd6VUxBQ1NYWU1IUms0alUyK0JRd3RVN2dIeTB1YitiTFJhTjQ2bjg0?=
 =?utf-8?B?dDdSSjJBaWI4V3Z5TWdBZWpxODhBSkdnUXJuN1ZlUGxvQkpkaWFTMGxzSzlB?=
 =?utf-8?B?YTl2d0k1bis2ZEtiWHE3MVp0L1Fxb3pENmYyZ1M2STRQcFdpdzRXR1djOGVS?=
 =?utf-8?B?WVB2ZE1Ka2RobEZJNlB2Y1ZPUFZwV3VlZHZOKzROakltaDNPcFUzNFExZzlS?=
 =?utf-8?B?UkgrQXZXWW5XN09xN05CZG8yQlM4RmZyWCticnpUY1lSdllIcSt6TCt2VWtN?=
 =?utf-8?B?UlVjbmZ4eEhlbXM4dmhEZ3hnN2NHVTFrWFp1bm5GdXZwYnNpV3NRTmRIVlpw?=
 =?utf-8?Q?fbr0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5231.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700bcf1b-02e8-49f3-d24c-08dca0d13523
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 11:12:37.9748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jN4UCT6dsa2NWAWGigP/oMU7yw+RmMRDwSGU3xV+KODr+1QUE5CAIbbupJUKnPH8fhQpiFfYlArfrY+f1EaeNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6710

SGksDQoNClBhdGNoIGluIGJlbG93IGxpbmsgaGVscGVkIHVzIHRvIHJlc29sdmUgdGhpcyBpc3N1
ZSwNCmh0dHBzOi8vY29tbXVuaXR5LmluZmluZW9uLmNvbS90NS9PUFRJR0EtVFBNL2ktTVg4TVAt
d2l0aC1UUE0tU0xCOTY3MC90ZC1wLzQwMzk0OSMuDQoNCk5vdyBUUE0gZHJpdmVyIGlzIHByb2Jl
ZCBiZWZvcmUgSU1BIHRlc3QuDQoNClJlZ2FyZHMsDQpLYXJ0aGlrDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3
ZWljbG91ZC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMTgsIDIwMjQgNjoxMiBQTQ0KPiBU
bzogVGhhbmdhdmVsLCBLYXJ0aGlrIDxrYXJ0aGlrLnRoYW5nYXZlbEBhbWQuY29tPjsgbGludXgt
c2VjdXJpdHktDQo+IG1vZHVsZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXNwaUB2Z2VyLmtlcm5l
bC5vcmcNCj4gQ2M6IEdhZGRpcGF0aSwgTmF2ZWVuIDxuYXZlZW4uZ2FkZGlwYXRpQGFtZC5jb20+
OyBOYXJyYSwgQmhhcmF0aCBLdW1hcg0KPiA8QmhhcmF0aEt1bWFyLk5hcnJhQGFtZC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBJTUEgUmVwb3J0cyBObyBUUE0gRGV2aWNlDQo+IA0KPiBPbiBUdWUsIDIw
MjQtMDYtMTggYXQgMTA6MjQgKzAwMDAsIFRoYW5nYXZlbCwgS2FydGhpayB3cm90ZToNCj4gPiBI
aSwNCj4gPg0KPiA+IENhbiB5b3UgcGxzIGxldCB1cyBrbm93IGhvdyB0byByZXNvbHZlIHRoaXMg
aXNzdWUuDQo+ID4gTG9va3MgbWFueSByZXBvcnRlZCB0aGUgc2FtZSBpc3N1ZSBpbiBmb3J1bXMu
DQo+IA0KPiBIaQ0KPiANCj4gdGhpcyBkaXNjdXNzaW9uIHNlZW1zIHRvIGJlIHJlbGF0ZWQ6DQo+
IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMTU1MDc1MzM1OC4xNzc2OC44NS5jYW1l
bEBsaW51eC5pYm0uY29tL3QvI201ZmQNCj4gMjdjYzljODBlOTBlNzgxY2NjNWUxYzNlNjkzMDE0
ZDAyNzhhMg0KPiANCj4gDQo+IE1heWJlIHRoZXJlIGNvdWxkIGJlIHN1Z2dlc3Rpb25zIHRoYXQg
YXBwbHkgdG8geW91ciBjYXNlLiBXZSBjYW4gYWxzbyByZXN1bWUNCj4gdGhlIGRpc2N1c3Npb24s
IGlmIHRoZSBmaXggaXMgbm90IHlldCB1cHN0cmVhbWVkLg0KPiANCj4gUm9iZXJ0bw0KPiANCj4g
PiBSZWdhcmRzLA0KPiA+IEthcnRoaWsNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPiA+IEZyb206IFRoYW5nYXZlbCwgS2FydGhpaw0KPiA+ID4gU2VudDogRnJpZGF5
LCBKdW5lIDcsIDIwMjQgMTI6NDkgUE0NCj4gPiA+IFRvOiBsaW51eC1zZWN1cml0eS1tb2R1bGVA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBDYzogR2Fk
ZGlwYXRpLCBOYXZlZW4gPG5hdmVlbi5nYWRkaXBhdGlAYW1kLmNvbT47IE5hcnJhLCBCaGFyYXRo
DQo+ID4gPiBLdW1hciA8QmhhcmF0aEt1bWFyLk5hcnJhQGFtZC5jb20+DQo+ID4gPiBTdWJqZWN0
OiBJTUEgUmVwb3J0cyBObyBUUE0gRGV2aWNlDQo+ID4gPg0KPiA+ID4gSGksDQo+ID4gPg0KPiA+
ID4gV2UgYXJlIGJvb3RpbmcgbGludXggdjYuMS4zMCBvbiBYaWxpbnggWnlucU1QIFNvQyB3aGlj
aCBpcyB1c2luZyBBUk0tQTUzLg0KPiA+ID4gV2Ugd2FudCB0byBydW4gSU1BIG9uIFRQTSBkZXZp
Y2UgY29ubmVjdGVkIG92ZXIgU1BJIGludGVyZmFjZS4NCj4gPiA+IER1cmluZyBib290aW5nIGZv
dW5kIHRoYXQgSU1BIHJlcG9ydHMgIk5vIFRQTSBjaGlwIGZvdW5kIi4NCj4gPiA+DQo+ID4gPiBQ
bGVhc2UgZmluZCB0aGUgYmVsb3cgbG9ncyB3aGljaCBzaG93cyBJTUEgc3Vic3lzdGVtIGluaXQg
Y2FsbGVkDQo+ID4gPiBiZWZvcmUgVFBNIGRldmljZS4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gWyAg
ICAwLjAwMDAwMF0gTGludXggdmVyc2lvbiA2LjEuMzAteGlsaW54LXYyMDIzLjIgKG9lLXVzZXJA
b2UtaG9zdCkNCj4gKGFhcmNoNjQtDQo+ID4gPiB4aWxpbngtbGludXgtZ2NjIChHQ0MpIDEyLjIu
MCwgR05VIGxkIChHTlUgQmludXRpbHMpDQo+ID4gPiAyLjM5LjAuMjAyMjA4MTkpICMxIFNNUCBG
cmkgU2VwIDIyIDEwOjQxOjAxIFVUQyAyMDIzDQo+ID4gPiBbICAgIDAuMDAwMDAwXSBNYWNoaW5l
IG1vZGVsOiB4bG54LHp5bnFtcA0KPiA+ID4gLi4uDQo+ID4gPiBbICAgIDIuNTYxNDA1XSBpbWE6
IE5vIFRQTSBjaGlwIGZvdW5kLCBhY3RpdmF0aW5nIFRQTS1ieXBhc3MhDQo+ID4gPiBbICAgIDIu
NTY3MTk5XSBpbWE6IEFsbG9jYXRlZCBoYXNoIGFsZ29yaXRobTogc2hhMjU2DQo+ID4gPiAuLi4N
Cj4gPiA+IFsgICAgMy43MjcxMDVdIHRwbV90aXNfc3BpIHNwaTEuMDogMi4wIFRQTSAoZGV2aWNl
LWlkIDB4MUIsIHJldi1pZCAyMikNCj4gPiA+IFsgICAgMy43NjQxNTJdIHRwbSB0cG0wOiBzdGFy
dGluZyB1cCB0aGUgVFBNIG1hbnVhbGx5DQo+ID4gPiAuLi4NCj4gPiA+DQo+ID4gPiBJbiBzZWN1
cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9tYWluLmMNCj4gPiA+IGxhdGVfaW5pdGNhbGwoaW5pdF9p
bWEpOwkvKiBTdGFydCBJTUEgYWZ0ZXIgdGhlIFRQTSBpcyBhdmFpbGFibGUgKi8NCj4gPiA+DQo+
ID4gPiBBcyBwZXIgYWJvdmUgY29tbWVudCBsaW5lIElNQSBzaG91bGQgc3RhcnQgYWZ0ZXIgVFBN
IGlzIGF2YWlsYWJsZS4NCj4gPiA+IEJ1dCB3ZSBhcmUgb2JzZXJ2aW5nIHRoZSBvcHBvc2l0ZSBi
ZWhhdmlvci4NCj4gPiA+IFBsZWFzZSBsZXQgdXMga25vdyBob3cgdG8gZml4IHRoaXMgaXNzdWUu
DQo+ID4gPg0KPiA+ID4gLUthcnRoaWsNCg0K

